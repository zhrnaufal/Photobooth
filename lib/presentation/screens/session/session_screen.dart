import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';
import 'package:drift/drift.dart' show Value;

class SessionScreen extends ConsumerStatefulWidget {
  final int sesiId;
  const SessionScreen({super.key, required this.sesiId});
  @override
  ConsumerState<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen>
    with TickerProviderStateMixin {
  Sesi? _sesi;
  Paket? _paket;
  final List<String> _capturedPaths = [];
  int _currentShot = 0;
  int _countdown = 0;
  bool _isCapturing = false;
  bool _loading = true;
  Timer? _countdownTimer;

  late AnimationController _countdownAnim;
  late AnimationController _flashAnim;

  @override
  void initState() {
    super.initState();
    _countdownAnim = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _flashAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _init();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownAnim.dispose();
    _flashAnim.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    final db = ref.read(dbProvider);
    _sesi = await db.getSesiById(widget.sesiId);
    if (_sesi == null) { setState(() => _loading = false); return; }
    _paket = await db.getPaketById(_sesi!.idPaket);
    setState(() => _loading = false);
    await Future.delayed(const Duration(milliseconds: 500));
    _startCountdownForShot();
  }

  void _startCountdownForShot() {
    if (_currentShot >= (_paket?.jumlahFoto ?? 0)) return;
    setState(() => _countdown = 5);
    _countdownAnim.repeat();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown <= 1) {
        t.cancel();
        _countdownAnim.stop();
        _capturePhoto();
      } else {
        setState(() => _countdown--);
      }
    });
  }

  Future<void> _capturePhoto() async {
    setState(() => _isCapturing = true);

    // Flash effect
    await _flashAnim.forward();
    await _flashAnim.reverse();

    // On Android: use USB camera (PTP). On desktop/emulator: use image_picker or simulated.
    String? path;
    try {
      if (Platform.isAndroid) {
        // TODO: replace with real PTP camera capture
        final picker = ImagePicker();
        final img = await picker.pickImage(source: ImageSource.camera);
        path = img?.path;
      } else {
        // Desktop: open file picker as substitute for camera
        final picker = ImagePicker();
        final img = await picker.pickImage(source: ImageSource.gallery);
        path = img?.path;
      }
    } catch (_) {
      // Fallback: simulate with a placeholder
      path = await _createPlaceholder(_currentShot + 1);
    }

    if (path != null) {
      // Save to session folder
      final dir = await _sessionDir();
      final destPath = p.join(dir, 'IMG_${_currentShot + 1}_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await File(path).copy(destPath);

      final db = ref.read(dbProvider);
      await db.insertSesiFoto(SesiFotosCompanion(
        idSesi: Value(widget.sesiId),
        pathFileLokal: Value(destPath),
        urutan: Value(_currentShot + 1),
      ));
      _capturedPaths.add(destPath);
    }

    setState(() {
      _currentShot++;
      _isCapturing = false;
    });

    if (_currentShot >= (_paket?.jumlahFoto ?? 0)) {
      // All shots done
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) context.pushReplacement('/result/${widget.sesiId}');
    } else {
      await Future.delayed(const Duration(seconds: 2));
      _startCountdownForShot();
    }
  }

  Future<String> _sessionDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'photobooth', 'sesi_${widget.sesiId}'));
    await dir.create(recursive: true);
    return dir.path;
  }

  Future<String> _createPlaceholder(int n) async {
    final dir = await _sessionDir();
    final path = p.join(dir, 'placeholder_$n.jpg');
    // Create a minimal placeholder file
    final file = File(path);
    if (!file.existsSync()) file.writeAsBytesSync([]);
    return path;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.gold)));
    }

    final total = _paket?.jumlahFoto ?? 0;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(color: Colors.black),

          // Camera preview area (placeholder on desktop)
          Center(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                color: const Color(0xFF111111),
                child: _isCapturing
                    ? Container(color: Colors.white)
                    : const Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.camera, size: 80, color: Color(0xFF333355)),
                          SizedBox(height: 16),
                          Text('Tampilan Kamera', style: TextStyle(color: Color(0xFF444466))),
                        ]),
                      ),
              ),
            ),
          ),

          // Flash overlay
          AnimatedBuilder(
            animation: _flashAnim,
            builder: (_, __) => Opacity(
              opacity: _flashAnim.value,
              child: Container(color: Colors.white),
            ),
          ),

          // Top HUD
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Shot counter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(children: List.generate(total, (i) => Container(
                      width: 12, height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i < _currentShot ? AppColors.gold : Colors.white24,
                      ),
                    ))),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${_currentShot + 1} / $total',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),

          // Countdown overlay
          if (_countdown > 0 && !_isCapturing)
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  '$_countdown',
                  key: ValueKey(_countdown),
                  style: TextStyle(
                    fontSize: 160,
                    fontWeight: FontWeight.bold,
                    color: _countdown <= 2 ? AppColors.error : AppColors.gold,
                    shadows: const [Shadow(color: Colors.black54, blurRadius: 20)],
                  ),
                ),
              ),
            ),

          // Bottom bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent]),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_countdown > 0 ? Icons.timer : Icons.camera_alt,
                    color: AppColors.gold, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    _countdown > 0
                        ? 'Bersiap... $_countdown detik'
                        : _isCapturing ? 'Mengambil foto...' : 'Menunggu...',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
