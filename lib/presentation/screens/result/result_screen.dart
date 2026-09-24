import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final int sesiId;
  const ResultScreen({super.key, required this.sesiId});
  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  List<SesiFoto> _fotos = [];
  Sesi? _sesi;
  bool _loading = true;
  int _autoReturnSecs = 30;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = ref.read(dbProvider);
    _sesi = await db.getSesiById(widget.sesiId);
    _fotos = await db.getFotosBySesi(widget.sesiId);
    await db.updateStatusSesi(widget.sesiId, 'selesai');
    setState(() => _loading = false);
    _startAutoReturn();
  }

  void _startAutoReturn() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _autoReturnSecs--);
      return _autoReturnSecs > 0 && mounted;
    }).then((_) {
      if (mounted) context.go('/');
    });
  }

  String _galleryUrl() {
    final kode = _sesi?.kodeSesi ?? '';
    const baseUrl = 'https://photobooth.id/gallery'; // from settings ideally
    return '$baseUrl?kode=$kode';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.gold)));
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D2B), AppColors.bgDark]),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Left: photos grid
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Text('🎉 ', style: TextStyle(fontSize: 24)),
                        Text('Foto Kamu Sudah Siap!',
                          style: Theme.of(context).textTheme.headlineLarge),
                      ]),
                      const SizedBox(height: 8),
                      Text('Kode sesi: ${_sesi?.kodeSesi ?? '-'}',
                        style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 24),

                      // Photo grid
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: _fotos.length,
                          itemBuilder: (_, i) {
                            final file = File(_fotos[i].pathFileLokal);
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: file.existsSync()
                                  ? Image.file(file, fit: BoxFit.cover)
                                  : Container(
                                      color: AppColors.bgCard,
                                      child: Center(child: Text('Foto ${i + 1}',
                                        style: const TextStyle(color: AppColors.textMuted)))),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right: QR + actions
              Container(
                width: 320,
                margin: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // QR Code for gallery
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(children: [
                        const Text('Lihat di Galeri Online',
                          style: TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 16),
                        QrImageView(data: _galleryUrl(), size: 180, backgroundColor: Colors.white),
                        const SizedBox(height: 12),
                        Text(_sesi?.kodeSesi ?? '',
                          style: const TextStyle(
                            color: Color(0xFF666680), fontSize: 12, letterSpacing: 2)),
                      ]),
                    ),

                    const SizedBox(height: 24),

                    // Print button
                    ElevatedButton.icon(
                      onPressed: () {}, // TODO: trigger print
                      icon: const Icon(Icons.print),
                      label: const Text('CETAK FOTO'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52)),
                    ),

                    const SizedBox(height: 12),

                    // Auto return countdown
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(children: [
                        const Icon(Icons.timer, color: AppColors.textMuted, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Kembali ke awal dalam $_autoReturnSecs detik',
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                          ),
                        ),
                      ]),
                    ),

                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: () => context.go('/'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        side: const BorderSide(color: AppColors.textMuted),
                      ),
                      child: const Text('Selesai', style: TextStyle(color: AppColors.textSecond)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
