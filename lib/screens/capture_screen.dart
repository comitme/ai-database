import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saver_gallery/saver_gallery.dart';

import 'package:ai_data_preparer/models/data_item.dart';
import 'package:ai_data_preparer/providers/data_provider.dart';
import 'package:ai_data_preparer/services/storage_service.dart';
import 'package:ai_data_preparer/utils/permissions.dart';

class CaptureScreen extends ConsumerWidget {
  const CaptureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picker = ImagePicker();

    Future<void> _pick(ImageSource src) async {
      if (!await ensurePhotoPermission()) return;
      final XFile? picked = await picker.pickImage(
        source: src,
        imageQuality: 90,
      );
      if (picked == null) return;

      final savedPath = await StorageService.saveTempFile(File(picked.path));

      final bytes = await File(savedPath).readAsBytes();
      await SaverGallery.saveImage(
        Uint8List.fromList(bytes),
        quality: 95,
        fileName: '${DateTime.now().millisecondsSinceEpoch}.jpg',
        androidRelativePath: 'Pictures/AI_Preparer', // album
        skipIfExists: false, // ← wymagane
      );

      ref.read(dataProvider.notifier).add(DataItem.newLocal(savedPath));

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Zdjęcie zapisane')));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Capture')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Zdjęcie'),
              onPressed: () => _pick(ImageSource.camera),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('Galeria'),
              onPressed: () => _pick(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
