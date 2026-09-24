import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photobooth/core/theme/app_theme.dart';

class IdleScreen extends StatefulWidget {
  const IdleScreen({super.key});
  @override
  State<IdleScreen> createState() => _IdleScreenState();
}

class _IdleScreenState extends State<IdleScreen> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late AnimationController _shimmerCtrl;
  late AnimationController _floatCtrl;
  late Animation<double> _pulseAnim;
  late Animation<double> _shimmerAnim;
  late Animation<double> _floatAnim;

  int _adminTapCount = 0;
  DateTime? _firstTap;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.97, end: 1.03).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _shimmerCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
    _shimmerAnim = Tween(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut));

    _floatCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
    _floatAnim = Tween(begin: -8.0, end: 8.0).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _shimmerCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  void _handleAdminTap() {
    final now = DateTime.now();
    if (_firstTap == null || now.difference(_firstTap!) > const Duration(seconds: 3)) {
      _firstTap = now;
      _adminTapCount = 1;
    } else {
      _adminTapCount++;
    }
    if (_adminTapCount >= 5) {
      _adminTapCount = 0;
      context.push('/admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Background ──
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0A0A1F), Color(0xFF0D0D1A), Color(0xFF050510)],
                stops: [0, 0.5, 1],
              ),
            ),
          ),

          // ── Decorative orbs ──
          Positioned(top: -100, right: -80,
            child: Container(width: 350, height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.gold.withValues(alpha: 0.12),
                  AppColors.gold.withValues(alpha: 0),
                ]),
              ))),
          Positioned(bottom: -80, left: -60,
            child: Container(width: 280, height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFF4040FF).withValues(alpha: 0.08),
                  Colors.transparent,
                ]),
              ))),

          // ── Particle dots ──
          ...List.generate(12, (i) {
            final random = Random(i * 7);
            return Positioned(
              left: random.nextDouble() * size.width,
              top:  random.nextDouble() * size.height,
              child: AnimatedBuilder(
                animation: _floatCtrl,
                builder: (_, __) => Opacity(
                  opacity: 0.15 + random.nextDouble() * 0.25,
                  child: Transform.translate(
                    offset: Offset(0, _floatAnim.value * (i % 2 == 0 ? 1 : -0.5)),
                    child: Container(
                      width: 3 + random.nextDouble() * 3,
                      height: 3 + random.nextDouble() * 3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i % 3 == 0 ? AppColors.gold : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

          // ── Admin tap zone ──
          Positioned(
            top: 0, left: 0,
            child: GestureDetector(
              onTap: _handleAdminTap,
              child: Container(width: 80, height: 80, color: Colors.transparent),
            ),
          ),

          // ── Main content ──
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo mark
                AnimatedBuilder(
                  animation: _floatCtrl,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, _floatAnim.value * 0.5),
                    child: child,
                  ),
                  child: Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.gold, AppColors.goldDark],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(color: AppColors.gold.withValues(alpha: 0.4), blurRadius: 30, spreadRadius: 2),
                      ],
                    ),
                    child: const Icon(Icons.camera_alt, size: 40, color: Color(0xFF0A0A1A)),
                  ),
                ),

                const SizedBox(height: 28),

                // Label
                Text('✦  PHOTOBOOTH  ✦',
                  style: TextStyle(
                    color: AppColors.gold.withValues(alpha: 0.8),
                    fontSize: 12,
                    letterSpacing: 8,
                    fontWeight: FontWeight.w500,
                  )),

                const SizedBox(height: 14),

                // Title with shimmer
                AnimatedBuilder(
                  animation: _shimmerAnim,
                  builder: (_, child) => ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: const [Colors.white, AppColors.gold, Colors.white, Colors.white],
                      stops: [
                        (_shimmerAnim.value - 0.4).clamp(0.0, 1.0),
                        _shimmerAnim.value.clamp(0.0, 1.0),
                        (_shimmerAnim.value + 0.1).clamp(0.0, 1.0),
                        1.0,
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      'Self Photo Studio',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Abadikan momen terbaikmu bersama kami',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 64),

                // CTA Button with pulse
                ScaleTransition(
                  scale: _pulseAnim,
                  child: GestureDetector(
                    onTap: () => context.push('/packages'),
                    child: Container(
                      width: 260,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.goldLight, AppColors.gold, AppColors.goldDark],
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gold.withValues(alpha: 0.5),
                            blurRadius: 25, spreadRadius: 2, offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_circle_filled, color: Color(0xFF0A0A1A), size: 24),
                          SizedBox(width: 10),
                          Text('MULAI SESI',
                            style: TextStyle(
                              color: Color(0xFF0A0A1A),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            )),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Hint
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 30, height: 1, color: Colors.white.withValues(alpha: 0.15)),
                  const SizedBox(width: 12),
                  Text('Ketuk untuk memulai sesi foto',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13)),
                  const SizedBox(width: 12),
                  Container(width: 30, height: 1, color: Colors.white.withValues(alpha: 0.15)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
