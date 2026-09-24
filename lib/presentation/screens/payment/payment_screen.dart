import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';
import 'package:photobooth/services/payment/midtrans_service.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

final _midtransProvider = Provider((_) => MidtransService());

class PaymentScreen extends ConsumerStatefulWidget {
  final int paketId;
  const PaymentScreen({super.key, required this.paketId});
  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  Paket? _paket;
  String _qrValue = '';
  String _orderId = '';
  int _sesiId = 0;
  bool _loading = true;
  String? _error;
  Timer? _pollTimer;
  int _countdown = 300; // 5 minutes
  Timer? _countdownTimer;
  bool _paid = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _countdownTimer?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    final db = ref.read(dbProvider);
    final midtrans = ref.read(_midtransProvider);

    // Load paket
    _paket = await db.getPaketById(widget.paketId);
    if (_paket == null) { setState(() => _error = 'Paket tidak ditemukan'); return; }

    // Load Midtrans config from settings
    final serverKey = await db.getSetting(SettingKeys.midtransServerKey) ?? '';
    final env = await db.getSetting(SettingKeys.midtransEnv) ?? 'sandbox';
    midtrans.configure(serverKey: serverKey, isSandbox: env == 'sandbox');

    // Create sesi record
    _orderId = midtrans.generateOrderId();
    final kodeSesi = 'PB-${const Uuid().v4().substring(0, 6).toUpperCase()}';
    _sesiId = await db.insertSesi(SesisCompanion(
      kodeSesi: Value(kodeSesi),
      idPaket: Value(widget.paketId),
      tanggal: Value(DateTime.now().millisecondsSinceEpoch),
      totalBayar: Value(_paket!.harga),
      midtransOrderId: Value(_orderId),
    ));

    // Charge QRIS
    final result = await midtrans.chargeQris(
      orderId: _orderId,
      amount: _paket!.harga,
      itemName: _paket!.namaPaket,
    );

    if (result is QrGenerated) {
      setState(() { _qrValue = result.qrValue; _loading = false; });
      _startPolling(midtrans);
      _startCountdown();
    } else if (result is PaymentFailed) {
      setState(() { _error = result.reason; _loading = false; });
    }
  }

  void _startPolling(MidtransService midtrans) {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final status = await midtrans.checkStatus(_orderId);
      if (status is PaymentPaid && mounted) {
        _pollTimer?.cancel();
        _countdownTimer?.cancel();
        final db = ref.read(dbProvider);
        await db.updateStatusBayar(_sesiId, 'paid');
        setState(() => _paid = true);
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) context.pushReplacement('/frame/$_sesiId');
      } else if (status is PaymentFailed && mounted) {
        _pollTimer?.cancel();
        setState(() => _error = (status).reason);
      }
    });
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_countdown <= 0) {
        _countdownTimer?.cancel();
        _pollTimer?.cancel();
        if (mounted) setState(() => _error = 'QR kode kadaluarsa');
      } else {
        setState(() => _countdown--);
      }
    });
  }

  String get _countdownStr {
    final m = _countdown ~/ 60;
    final s = _countdown % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFF0D0D2B), AppColors.bgDark]),
        ),
        child: SafeArea(
          child: _loading
              ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircularProgressIndicator(color: AppColors.gold),
            SizedBox(height: 24),
            Text('Membuat QR pembayaran...', style: TextStyle(color: AppColors.textSecond)),
          ]))
              : _error != null
              ? _ErrorView(error: _error!, onRetry: () {
            setState(() { _loading = true; _error = null; });
            _init();
          }, onBack: () => context.pop())
              : _paid
              ? const _PaidView()
              : _QrView(
            paket: _paket!,
            qrValue: _qrValue,
            countdown: _countdownStr,
            totalFmt: fmt.format(_paket!.harga),
            onCancel: () {
              _pollTimer?.cancel();
              _countdownTimer?.cancel();
              context.pop();
            },
          ),
        ),
      ),
    );
  }
}



class _QrView extends StatelessWidget {
  final Paket paket;
  final String qrValue;
  final String countdown;
  final String totalFmt;
  final VoidCallback onCancel;
  const _QrView({required this.paket, required this.qrValue, required this.countdown,
    required this.totalFmt, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // Left: info
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('✦ PEMBAYARAN ✦',
                  style: TextStyle(color: AppColors.gold, fontSize: 12, letterSpacing: 4)),
              const SizedBox(height: 16),
              Text('Scan QR untuk\nbayar sekarang',
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 32),
              _InfoRow(label: 'Paket', value: paket.namaPaket),
              const SizedBox(height: 12),
              _InfoRow(label: 'Jumlah Foto', value: '${paket.jumlahFoto} foto'),
              const SizedBox(height: 12),
              _InfoRow(label: 'Total', value: totalFmt, highlight: true),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: Row(children: [
                  const Icon(Icons.timer, color: AppColors.warning, size: 20),
                  const SizedBox(width: 10),
                  Text('Berlaku $countdown',
                      style: const TextStyle(color: AppColors.warning, fontWeight: FontWeight.bold)),
                ]),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(160, 48),
                  side: const BorderSide(color: AppColors.textMuted),
                  foregroundColor: AppColors.textSecond,
                ),
                child: const Text('Batalkan'),
              ),
            ],
          ),
        ),
      ),

      // Right: QR
      Container(
        width: 360,
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.2), blurRadius: 40)],
        ),
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('QRIS', style: TextStyle(
              color: Color(0xFF1A1A2E), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 4)),
          const SizedBox(height: 16),
          QrImageView(data: qrValue.isEmpty ? 'https://photobooth.id' : qrValue,
              size: 240, backgroundColor: Colors.white),
          const SizedBox(height: 16),
          const Text('Scan dengan aplikasi e-wallet apapun',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF666680), fontSize: 13)),
        ]),
      ),
    ]);
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  final bool highlight;
  const _InfoRow({required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: const TextStyle(color: AppColors.textSecond)),
      Text(value, style: TextStyle(
          color: highlight ? AppColors.gold : Colors.white,
          fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          fontSize: highlight ? 20 : 16)),
    ],
  );
}

class _PaidView extends StatelessWidget {
  const _PaidView();
  @override
  Widget build(BuildContext context) => const Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.check_circle, color: AppColors.success, size: 80),
      SizedBox(height: 24),
      Text('Pembayaran Berhasil!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Mengarahkan ke pilihan frame...', style: TextStyle(color: AppColors.textSecond)),
    ]),
  );
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry, onBack;
  const _ErrorView({required this.error, required this.onRetry, required this.onBack});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.error_outline, color: AppColors.error, size: 64),
      const SizedBox(height: 24),
      Text('Gagal memproses pembayaran', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 8),
      Text(error, style: const TextStyle(color: AppColors.error)),
      const SizedBox(height: 40),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        OutlinedButton(onPressed: onBack, child: const Text('Kembali')),
        const SizedBox(width: 16),
        ElevatedButton(onPressed: onRetry,
            style: ElevatedButton.styleFrom(minimumSize: const Size(140, 48)),
            child: const Text('Coba Lagi')),
      ]),
    ]),
  );
}