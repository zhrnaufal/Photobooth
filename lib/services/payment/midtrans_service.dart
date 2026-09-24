import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

sealed class PaymentResult {}
class QrGenerated extends PaymentResult {
  final String qrValue;
  final String orderId;
  QrGenerated({required this.qrValue, required this.orderId});
}
class PaymentPaid extends PaymentResult {}
class PaymentPending extends PaymentResult {}
class PaymentFailed extends PaymentResult {
  final String reason;
  PaymentFailed(this.reason);
}

class MidtransService {
  String _serverKey = '';
  bool _isSandbox = false;

  String get _baseUrl => _isSandbox
      ? 'https://api.sandbox.midtrans.com'
      : 'https://api.midtrans.com';

  String get _authHeader =>
      'Basic ${base64Encode(utf8.encode('$_serverKey:'))}';

  void configure({required String serverKey, required bool isSandbox}) {
    _serverKey = serverKey;
    _isSandbox = isSandbox;
  }

  bool get isConfigured => _serverKey.isNotEmpty;

  // ── Charge QRIS ───────────────────────────────────────────────────────

  Future<PaymentResult> chargeQris({
    required String orderId,
    required double amount,
    required String itemName,
  }) async {
    try {
      // ====================================================================
      // OPSI 1: KODE LAMA TANPA ACQUIRER (Saat ini dinonaktifkan / comment)
      // Hapus tanda /* dan */ untuk mengaktifkan kode ini kembali.
      // ====================================================================
      /*
      final body = jsonEncode({
        'payment_type': 'qris',
        'transaction_details': {
          'order_id': orderId,
          'gross_amount': amount.toInt(),
        },
        'item_details': [
          {
            'id': orderId,
            'price': amount.toInt(),
            'quantity': 1,
            'name': itemName,
          }
        ],
      });
      */

      // ====================================================================
      // OPSI 2: KODE BARU DENGAN ACQUIRER (Saat ini aktif)
      // Tambahkan tanda /* di atas dan */ di bawah kode ini untuk menonaktifkan.
      // ====================================================================
      final body = jsonEncode({
        'payment_type': 'qris',
        'transaction_details': {
          'order_id': orderId,
          'gross_amount': amount.toInt(),
        },
        'item_details': [
          {
            'id': orderId,
            'price': amount.toInt(),
            'quantity': 1,
            'name': itemName,
          }
        ],
        'qris': {
          'acquirer': 'gopay'
        }
      });
      // ====================================================================

      final res = await http.post(
        Uri.parse('$_baseUrl/v2/charge'),
        headers: {
          'Authorization': _authHeader,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final statusCode = json['status_code']?.toString();

      if (statusCode != '201') {
        return PaymentFailed(json['status_message'] ?? 'Charge gagal');
      }

      // Extract QR string
      String qrValue = json['qr_string'] ?? '';
      if (qrValue.isEmpty) {
        final actions = json['actions'] as List<dynamic>?;
        final qrAction = actions?.firstWhere(
              (a) => a['name'] == 'generate-qr-code',
          orElse: () => null,
        );
        qrValue = qrAction?['url'] ?? '';
      }

      return QrGenerated(qrValue: qrValue, orderId: orderId);
    } catch (e) {
      return PaymentFailed('Koneksi gagal: $e');
    }
  }

  // ── Check status ──────────────────────────────────────────────────────

  Future<PaymentResult> checkStatus(String orderId) async {
    try {
      final res = await http.get(
        Uri.parse('$_baseUrl/v2/$orderId/status'),
        headers: {
          'Authorization': _authHeader,
          'Accept': 'application/json',
        },
      );
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      switch (json['transaction_status']) {
        case 'settlement':
        case 'capture':
          return PaymentPaid();
        case 'pending':
          return PaymentPending();
        case 'deny':
        case 'failure':
          return PaymentFailed(json['status_message'] ?? 'Ditolak');
        case 'expire':
          return PaymentFailed('QR kode kadaluarsa');
        case 'cancel':
          return PaymentFailed('Transaksi dibatalkan');
        default:
          return PaymentPending();
      }
    } catch (e) {
      return PaymentPending();
    }
  }

  // ── Poll until terminal ───────────────────────────────────────────────

  Stream<PaymentResult> pollStatus(
      String orderId, {
        Duration interval = const Duration(seconds: 3),
        Duration timeout = const Duration(minutes: 5),
      }) async* {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final result = await checkStatus(orderId);
      yield result;
      if (result is! PaymentPending) return;
      await Future.delayed(interval);
    }
    yield PaymentFailed('Waktu pembayaran habis');
  }

  Future<void> cancelTransaction(String orderId) async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/v2/$orderId/cancel'),
        headers: {'Authorization': _authHeader},
      );
    } catch (_) {}
  }

  String generateOrderId() =>
      'PB-${const Uuid().v4().substring(0, 8).toUpperCase()}';
}