import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';
import 'package:intl/intl.dart';

final paketListProvider = StreamProvider<List<Paket>>((ref) =>
    ref.watch(dbProvider).watchAktifPakets());

class PackageListScreen extends ConsumerWidget {
  const PackageListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pakets = ref.watch(paketListProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF0A0A1F), Color(0xFF0D0D1A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 28, 32, 0),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.bgCardLight),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Container(
                        width: 4, height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.gold,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Pilih Paket',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    ]),
                    const SizedBox(height: 2),
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text('Pilih paket yang sesuai untuk kamu',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                    ),
                  ]),
                ]),
              ),

              const SizedBox(height: 28),

              // ── Grid ──
              Expanded(
                child: pakets.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (list) {
                    if (list.isEmpty) {
                      return Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.inventory_2_outlined, size: 72, color: AppColors.textMuted),
                          const SizedBox(height: 16),
                          const Text('Belum ada paket',
                              style: TextStyle(fontSize: 18, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          const Text('Hubungi admin untuk menambahkan paket',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                        ]),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 360,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: list.length,
                      itemBuilder: (_, i) => _PackageCard(paket: list[i], index: i),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackageCard extends StatefulWidget {
  final Paket paket;
  final int index;
  const _PackageCard({required this.paket, required this.index});
  @override
  State<_PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<_PackageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverCtrl;
  late Animation<double> _hoverAnim;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _hoverCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _hoverAnim = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _hoverCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() { _hoverCtrl.dispose(); super.dispose(); }

  // Different accent colors per card
  static const _accents = [AppColors.gold, Color(0xFF7C6BF5), Color(0xFF3AB9F0), Color(0xFFE57373)];

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final mins = widget.paket.durasiSesi ~/ 60;
    final accent = _accents[widget.index % _accents.length];

    return MouseRegion(
      onEnter: (_) { setState(() => _hovered = true); _hoverCtrl.forward(); },
      onExit:  (_) { setState(() => _hovered = false); _hoverCtrl.reverse(); },
      child: GestureDetector(
        onTap: () => context.push('/payment/${widget.paket.id}'),
        child: AnimatedBuilder(
          animation: _hoverAnim,
          builder: (_, child) => Transform.translate(
            offset: Offset(0, -4 * _hoverAnim.value),
            child: child,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [
                  AppColors.bgCard,
                  Color.lerp(AppColors.bgCard, accent, 0.08)!,
                ],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: _hovered ? accent.withValues(alpha: 0.5) : AppColors.bgCardLight,
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: _hovered ? 0.2 : 0.05),
                  blurRadius: _hovered ? 24 : 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon badge
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.camera_alt_outlined, color: accent, size: 26),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accent.withValues(alpha: 0.2)),
                    ),
                    child: Text('PAKET ${widget.index + 1}',
                        style: TextStyle(color: accent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ]),

                const SizedBox(height: 18),

                Text(widget.paket.namaPaket,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),

                if (widget.paket.deskripsi != null) ...[
                  const SizedBox(height: 6),
                  Text(widget.paket.deskripsi!,
                      style: const TextStyle(fontSize: 13, color: AppColors.textSecond),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                ],

                const Spacer(),

                // Features
                _Feature(icon: Icons.photo_camera_outlined, label: '${widget.paket.jumlahFoto} Foto', color: accent),
                const SizedBox(height: 8),
                _Feature(icon: Icons.print_outlined, label: '${widget.paket.jumlahCetak}× Cetak', color: accent),
                const SizedBox(height: 8),
                _Feature(icon: Icons.timer_outlined, label: '$mins Menit', color: accent),

                const SizedBox(height: 18),
                Divider(color: accent.withValues(alpha: 0.15), height: 1),
                const SizedBox(height: 16),

                // Price + CTA
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const Text('Harga', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                      Text(fmt.format(widget.paket.harga),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: accent)),
                    ]),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: accent.withValues(alpha: 0.4), blurRadius: 12)],
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _Feature({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Row(children: [
    Icon(icon, size: 16, color: color),
    const SizedBox(width: 8),
    Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecond)),
  ]);
}
