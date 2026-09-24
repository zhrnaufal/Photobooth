import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';
import 'package:drift/drift.dart' show Value;

// ── Providers ─────────────────────────────────────────────────────────────────
final _adminPaketsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(dbProvider).watchAktifPakets());
final _adminFramesProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(dbProvider).watchAktifFrames());
final _adminSesisProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(dbProvider).watchAllSesis());

// ── Root Screen ───────────────────────────────────────────────────────────────
class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});
  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  bool _pinVerified = false;
  String _pinInput = '';
  String? _pinError;

  Future<void> _verifyPin() async {
    final stored = await ref.read(dbProvider).getSetting(SettingKeys.adminPin) ?? '1234';
    if (_pinInput == stored) {
      setState(() { _pinVerified = true; _pinError = null; });
    } else {
      setState(() { _pinError = 'PIN salah, coba lagi.'; _pinInput = ''; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_pinVerified) {
      return _PinScreen(
        pin: _pinInput,
        error: _pinError,
        onDigit: (d) => setState(() { if (_pinInput.length < 6) _pinInput += d; }),
        onDelete: () => setState(() {
          if (_pinInput.isNotEmpty) _pinInput = _pinInput.substring(0, _pinInput.length - 1);
        }),
        onSubmit: _verifyPin,
        onCancel: () => context.pop(),
      );
    }
    return const _AdminDashboard();
  }
}

// ── PIN Screen ────────────────────────────────────────────────────────────────
class _PinScreen extends StatelessWidget {
  final String pin;
  final String? error;
  final Function(String) onDigit;
  final VoidCallback onDelete, onSubmit, onCancel;

  const _PinScreen({
    required this.pin, this.error,
    required this.onDigit, required this.onDelete,
    required this.onSubmit, required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D25), AppColors.bgDark],
          ),
        ),
        child: Center(
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 44),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.15)),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 40, offset: const Offset(0, 20)),
              ],
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              // Icon
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.gold, AppColors.goldDark],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                  boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 20)],
                ),
                child: const Icon(Icons.admin_panel_settings, size: 36, color: AppColors.bgDark),
              ),
              const SizedBox(height: 20),
              const Text('Admin Access',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 6),
              const Text('Masukkan PIN untuk melanjutkan',
                  style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
              const SizedBox(height: 32),

              // PIN dots
              Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(6, (i) =>
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 14, height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < pin.length ? AppColors.gold : Colors.transparent,
                    border: Border.all(
                      color: i < pin.length ? AppColors.gold : AppColors.textMuted,
                      width: 2,
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 10),
              AnimatedOpacity(
                opacity: error != null ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Text(error ?? '', style: const TextStyle(color: AppColors.error, fontSize: 13)),
              ),
              const SizedBox(height: 28),

              // Numpad
              ...[['1','2','3'], ['4','5','6'], ['7','8','9'], ['','0','⌫']].map((row) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((d) {
                      if (d.isEmpty) return const SizedBox(width: 84, height: 56);
                      final isDelete = d == '⌫';
                      return GestureDetector(
                        onTap: isDelete ? onDelete : () => onDigit(d),
                        child: Container(
                          width: 84, height: 56,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: isDelete ? AppColors.error.withValues(alpha: 0.1) : AppColors.bgCardLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.bgCardLight.withValues(alpha: 0.5)),
                          ),
                          alignment: Alignment.center,
                          child: Text(d,
                            style: TextStyle(
                              fontSize: isDelete ? 18 : 22,
                              fontWeight: FontWeight.w500,
                              color: isDelete ? AppColors.error : Colors.white,
                            )),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 48),
                    side: const BorderSide(color: AppColors.textMuted),
                    foregroundColor: AppColors.textSecond,
                  ),
                  child: const Text('Batal'),
                )),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(0, 48)),
                  child: const Text('Masuk'),
                )),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}

// ── Admin Dashboard ───────────────────────────────────────────────────────────
class _AdminDashboard extends StatelessWidget {
  const _AdminDashboard();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('ADMIN',
                style: TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ),
            const SizedBox(width: 12),
            const Text('Dashboard'),
          ]),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => context.pop(),
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            indicatorColor: AppColors.gold,
            labelColor: AppColors.gold,
            unselectedLabelColor: AppColors.textMuted,
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            tabs: const [
              Tab(icon: Icon(Icons.inventory_2_outlined, size: 20), text: 'Paket'),
              Tab(icon: Icon(Icons.photo_outlined, size: 20), text: 'Frame'),
              Tab(icon: Icon(Icons.tune_outlined, size: 20), text: 'Pengaturan'),
              Tab(icon: Icon(Icons.analytics_outlined, size: 20), text: 'Laporan'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_PaketTab(), _FrameTab(), _SettingsTab(), _LaporanTab()],
        ),
      ),
    );
  }
}

// ── Paket Tab ─────────────────────────────────────────────────────────────────
class _PaketTab extends ConsumerStatefulWidget {
  const _PaketTab();
  @override
  ConsumerState<_PaketTab> createState() => _PaketTabState();
}

class _PaketTabState extends ConsumerState<_PaketTab> {
  final _namaCtrl   = TextEditingController();
  final _fotoCtrl   = TextEditingController(text: '4');
  final _cetakCtrl  = TextEditingController(text: '1');
  final _durasiCtrl = TextEditingController(text: '600');
  final _hargaCtrl  = TextEditingController();
  final _deskCtrl   = TextEditingController();
  bool _showForm = false;

  @override
  void dispose() {
    _namaCtrl.dispose(); _fotoCtrl.dispose(); _cetakCtrl.dispose();
    _durasiCtrl.dispose(); _hargaCtrl.dispose(); _deskCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_namaCtrl.text.isEmpty || _hargaCtrl.text.isEmpty) return;
    await ref.read(dbProvider).insertPaket(PaketsCompanion(
      namaPaket:  Value(_namaCtrl.text.trim()),
      jumlahFoto: Value(int.tryParse(_fotoCtrl.text) ?? 4),
      jumlahCetak: Value(int.tryParse(_cetakCtrl.text) ?? 1),
      durasiSesi:  Value(int.tryParse(_durasiCtrl.text) ?? 600),
      harga: Value(double.tryParse(_hargaCtrl.text) ?? 0),
      deskripsi: Value(_deskCtrl.text.isEmpty ? null : _deskCtrl.text.trim()),
    ));
    _namaCtrl.clear(); _hargaCtrl.clear(); _deskCtrl.clear();
    _fotoCtrl.text = '4'; _cetakCtrl.text = '1'; _durasiCtrl.text = '600';
    setState(() => _showForm = false);
  }

  @override
  Widget build(BuildContext context) {
    final pakets = ref.watch(_adminPaketsProvider);
    final fmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Left: List ──
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Row(children: [
                  const Text('Daftar Paket',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  _GoldButton(
                    icon: _showForm ? Icons.close : Icons.add,
                    label: _showForm ? 'Batal' : 'Tambah Paket',
                    onTap: () => setState(() => _showForm = !_showForm),
                  ),
                ]),
              ),

              // List — takes remaining vertical space
              Expanded(
                child: pakets.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (list) {
                    if (list.isEmpty) {
                      return const _EmptyState(
                        icon: Icons.inventory_2_outlined,
                        message: 'Belum ada paket',
                        sub: 'Klik "Tambah Paket" untuk memulai',
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) {
                        final p = list[i];
                        return _PaketCard(
                          paket: p,
                          fmt: fmt,
                          onDelete: () => ref.read(dbProvider).softDeletePaket(p.id),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // ── Right: Form (animated) ──
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _showForm ? 320 : 0,
          child: _showForm
              ? SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 24, 24, 24),
                  child: _PaketForm(
                    namaCtrl: _namaCtrl, fotoCtrl: _fotoCtrl,
                    cetakCtrl: _cetakCtrl, durasiCtrl: _durasiCtrl,
                    hargaCtrl: _hargaCtrl, deskCtrl: _deskCtrl,
                    onSave: _save,
                    onCancel: () => setState(() => _showForm = false),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _PaketCard extends StatelessWidget {
  final Paket paket;
  final NumberFormat fmt;
  final VoidCallback onDelete;
  const _PaketCard({required this.paket, required this.fmt, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final mins = paket.durasiSesi ~/ 60;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.bgCardLight),
      ),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.camera_alt_outlined, color: AppColors.gold, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(paket.namaPaket,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Row(children: [
            _Chip('${paket.jumlahFoto} foto'),
            const SizedBox(width: 6),
            _Chip('${paket.jumlahCetak}x cetak'),
            const SizedBox(width: 6),
            _Chip('$mins mnt'),
          ]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(fmt.format(paket.harga),
              style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Hapus',
                  style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip(this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: AppColors.bgCardLight,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
  );
}

class _PaketForm extends StatelessWidget {
  final TextEditingController namaCtrl, fotoCtrl, cetakCtrl, durasiCtrl, hargaCtrl, deskCtrl;
  final VoidCallback onSave, onCancel;
  const _PaketForm({
    required this.namaCtrl, required this.fotoCtrl, required this.cetakCtrl,
    required this.durasiCtrl, required this.hargaCtrl, required this.deskCtrl,
    required this.onSave, required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.add_box_outlined, color: AppColors.gold, size: 20),
          const SizedBox(width: 8),
          const Text('Tambah Paket Baru',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ]),
        const SizedBox(height: 20),
        _Field(ctrl: namaCtrl, label: 'Nama Paket', hint: 'mis. Paket Basic'),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _Field(ctrl: fotoCtrl, label: 'Jumlah Foto', isNum: true)),
          const SizedBox(width: 10),
          Expanded(child: _Field(ctrl: cetakCtrl, label: 'Cetak', isNum: true)),
        ]),
        const SizedBox(height: 12),
        _Field(ctrl: durasiCtrl, label: 'Durasi (detik)', hint: '600 = 10 menit', isNum: true),
        const SizedBox(height: 12),
        _Field(ctrl: hargaCtrl, label: 'Harga (Rp)', hint: 'mis. 50000', isNum: true),
        const SizedBox(height: 12),
        _Field(ctrl: deskCtrl, label: 'Deskripsi (opsional)', maxLines: 2),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
            child: const Text('Batal'),
          )),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44)),
            child: const Text('Simpan'),
          )),
        ]),
      ]),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final String? hint;
  final bool isNum;
  final int maxLines;
  const _Field({required this.ctrl, required this.label, this.hint, this.isNum = false, this.maxLines = 1});

  @override
  Widget build(BuildContext context) => TextField(
    controller: ctrl,
    keyboardType: isNum ? TextInputType.number : TextInputType.text,
    maxLines: maxLines,
    style: const TextStyle(fontSize: 14),
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: AppColors.textMuted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
  );
}

// ── Frame Tab ─────────────────────────────────────────────────────────────────
class _FrameTab extends ConsumerWidget {
  const _FrameTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frames = ref.watch(_adminFramesProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 4),
        child: Text('Daftar Frame', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text('Salin file PNG transparan ke folder photobooth/frames/ lalu daftarkan path-nya.',
            style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
      ),
      const SizedBox(height: 16),
      Expanded(
        child: frames.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
          error: (e, _) => Center(child: Text('$e')),
          data: (list) {
            if (list.isEmpty) {
              return const _EmptyState(
                icon: Icons.photo_outlined,
                message: 'Belum ada frame',
                sub: 'Tambah frame PNG transparan ke folder frames/',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final f = list[i];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.bgCardLight),
                  ),
                  child: Row(children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.image_outlined, color: AppColors.gold, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(f.namaFrame, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(f.kategori, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      Text(f.pathFile,
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                          overflow: TextOverflow.ellipsis),
                    ])),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                      onPressed: () => ref.read(dbProvider).softDeleteFrame(f.id),
                    ),
                  ]),
                );
              },
            );
          },
        ),
      ),
    ]);
  }
}

// ── Settings Tab ──────────────────────────────────────────────────────────────
class _SettingsTab extends ConsumerWidget {
  const _SettingsTab();

  static const _keys = [
    (SettingKeys.namaStudio,        'Nama Studio',          Icons.store_outlined),
    (SettingKeys.midtransServerKey, 'Midtrans Server Key',  Icons.vpn_key_outlined),
    (SettingKeys.midtransEnv,       'Midtrans Env',         Icons.cloud_outlined),
    (SettingKeys.driveFolderRootId, 'Google Drive Folder ID', Icons.folder_outlined),
    (SettingKeys.galleryBaseUrl,    'Gallery Page URL',     Icons.link_outlined),
    (SettingKeys.adminPin,          'PIN Admin',            Icons.lock_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Text('Pengaturan Aplikasi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          itemCount: _keys.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final (key, label, icon) = _keys[i];
            return _SettingTile(settingKey: key, label: label, icon: icon);
          },
        ),
      ),
    ]);
  }
}

class _SettingTile extends ConsumerStatefulWidget {
  final String settingKey, label;
  final IconData icon;
  const _SettingTile({required this.settingKey, required this.label, required this.icon});
  @override
  ConsumerState<_SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends ConsumerState<_SettingTile> {
  bool _editing = false;
  late final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(dbProvider).getSetting(widget.settingKey).then((v) {
      if (mounted) setState(() => _ctrl.text = v ?? '');
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  bool get _isSecret =>
      widget.settingKey.contains('key') || widget.settingKey == SettingKeys.adminPin;

  String get _displayValue {
    if (_ctrl.text.isEmpty) return '(belum diatur)';
    if (_isSecret) return '${_ctrl.text.substring(0, _ctrl.text.length.clamp(0, 4))}••••';
    return _ctrl.text;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _editing ? AppColors.gold.withValues(alpha: 0.5) : AppColors.bgCardLight,
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(widget.icon, size: 18, color: AppColors.gold),
          const SizedBox(width: 10),
          Text(widget.label,
              style: const TextStyle(color: AppColors.textSecond, fontSize: 13, fontWeight: FontWeight.w500)),
          const Spacer(),
          if (!_editing)
            GestureDetector(
              onTap: () => setState(() => _editing = true),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.edit_outlined, size: 14, color: AppColors.gold),
                  SizedBox(width: 4),
                  Text('Edit', style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
        ]),
        const SizedBox(height: 10),
        if (_editing) ...[
          TextField(
            controller: _ctrl,
            obscureText: _isSecret,
            autofocus: true,
            style: const TextStyle(fontSize: 14),
            decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12)),
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: OutlinedButton(
              onPressed: () => setState(() => _editing = false),
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
              child: const Text('Batal'),
            )),
            const SizedBox(width: 10),
            Expanded(child: ElevatedButton(
              onPressed: () async {
                await ref.read(dbProvider).setSetting(widget.settingKey, _ctrl.text);
                if (mounted) setState(() => _editing = false);
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(0, 40)),
              child: const Text('Simpan'),
            )),
          ]),
        ] else
          Text(_displayValue,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _ctrl.text.isEmpty ? AppColors.textMuted : Colors.white,
              )),
      ]),
    );
  }
}

// ── Laporan Tab ───────────────────────────────────────────────────────────────
class _LaporanTab extends ConsumerWidget {
  const _LaporanTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(_adminSesisProvider);
    final currFmt  = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final dateFmt  = DateFormat('dd MMM yyyy  HH:mm', 'id_ID');

    return sessions.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
      error: (e, _) => Center(child: Text('$e')),
      data: (list) {
        final paid  = list.where((s) => s.statusBayar == 'paid').toList();
        final total = paid.fold(0.0, (s, x) => s + x.totalBayar);

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Summary ──
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(children: [
              Expanded(child: _StatCard(
                label: 'Total Pemasukan',
                value: currFmt.format(total),
                icon: Icons.account_balance_wallet_outlined,
                color: const Color(0xFF4CAF50),
              )),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(
                label: 'Sesi Berhasil',
                value: '${paid.length}',
                icon: Icons.check_circle_outline,
                color: AppColors.gold,
              )),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(
                label: 'Total Sesi',
                value: '${list.length}',
                icon: Icons.camera_alt_outlined,
                color: AppColors.textSecond,
              )),
            ]),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: Text('Riwayat Sesi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),

          // ── List ──
          Expanded(
            child: list.isEmpty
                ? const _EmptyState(
                    icon: Icons.receipt_long_outlined,
                    message: 'Belum ada riwayat sesi',
                    sub: 'Sesi yang selesai akan tampil di sini',
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) {
                      final s = list[i];
                      final isPaid = s.statusBayar == 'paid';
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.bgCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.bgCardLight),
                        ),
                        child: Row(children: [
                          Container(
                            width: 8, height: 44,
                            decoration: BoxDecoration(
                              color: isPaid ? AppColors.success : AppColors.error,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(s.kodeSesi,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(dateFmt.format(DateTime.fromMillisecondsSinceEpoch(s.tanggal)),
                                style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ])),
                          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (isPaid ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(s.statusBayar.toUpperCase(),
                                  style: TextStyle(
                                    color: isPaid ? AppColors.success : AppColors.error,
                                    fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1,
                                  )),
                            ),
                            const SizedBox(height: 4),
                            Text(currFmt.format(s.totalBayar),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.gold, fontSize: 15)),
                          ]),
                        ]),
                      );
                    },
                  ),
          ),
        ]);
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.bgCard,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(children: [
      Icon(icon, color: color, size: 28),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        Text(value,
            style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
      ]),
    ]),
  );
}

// ── Shared Widgets ────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message, sub;
  const _EmptyState({required this.icon, required this.message, required this.sub});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, size: 64, color: AppColors.textMuted),
      const SizedBox(height: 16),
      Text(message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textMuted)),
      const SizedBox(height: 6),
      Text(sub, style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
    ]),
  );
}

class _GoldButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _GoldButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gold, AppColors.goldDark],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.gold.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: AppColors.bgDark),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.bgDark, fontWeight: FontWeight.bold, fontSize: 13)),
      ]),
    ),
  );
}
