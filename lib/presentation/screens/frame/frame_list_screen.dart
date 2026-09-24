import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:photobooth/core/theme/app_theme.dart';
import 'package:photobooth/data/datasources/app_database.dart';
import 'package:photobooth/main.dart';

final _framesProvider = StreamProvider.autoDispose<List<Frame>>((ref) =>
    ref.watch(dbProvider).watchAktifFrames());

class FrameListScreen extends ConsumerWidget {
  final int sesiId;
  const FrameListScreen({super.key, required this.sesiId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frames = ref.watch(_framesProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFF0D0D2B), AppColors.bgDark]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Pilih Frame', style: Theme.of(context).textTheme.headlineLarge),
                    Text('Pilih bingkai untuk foto kamu',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () => _skipFrame(context, ref),
                    child: const Text('Tanpa Frame'),
                  ),
                ]),
              ),

              Expanded(
                child: frames.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: AppColors.gold)),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (list) => list.isEmpty
                      ? _noFrames(context, ref)
                      : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: list.length,
                    itemBuilder: (_, i) => _FrameCard(
                      frame: list[i],
                      onTap: () => _selectFrame(context, ref, list[i].id),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noFrames(BuildContext context, WidgetRef ref) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.image, size: 64, color: AppColors.textMuted),
      const SizedBox(height: 16),
      Text('Belum ada frame', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => _skipFrame(context, ref),
        style: ElevatedButton.styleFrom(minimumSize: const Size(200, 48)),
        child: const Text('Lanjut Tanpa Frame'),
      ),
    ]),
  );

  Future<void> _selectFrame(BuildContext context, WidgetRef ref, int frameId) async {
    final db = ref.read(dbProvider);
    await db.updateSesiFrame(sesiId, frameId);
    if (context.mounted) context.pushReplacement('/session/$sesiId');
  }

  Future<void> _skipFrame(BuildContext context, WidgetRef ref) async {
    if (context.mounted) context.pushReplacement('/session/$sesiId');
  }
}

class _FrameCard extends StatelessWidget {
  final Frame frame;
  final VoidCallback onTap;
  const _FrameCard({required this.frame, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final file = File(frame.pathFile);
    final exists = file.existsSync();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.gold.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: exists
                    ? Image.file(file, fit: BoxFit.cover, width: double.infinity)
                    : Container(
                  color: AppColors.bgCardLight,
                  child: const Icon(Icons.image_outlined,
                      size: 48, color: AppColors.textMuted),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Text(frame.namaFrame,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(frame.kategori,
                    style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}