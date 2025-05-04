import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ai_data_preparer/providers/data_provider.dart';

class TagScreen extends ConsumerWidget {
  const TagScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Oznacz dane')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return ListTile(
            leading: Image.file(File(item.path), width: 48, height: 48),
            title: Text(item.label.isEmpty ? '⟨brak etykiety⟩' : item.label),
            trailing: Icon(item.synced ? Icons.cloud_done : Icons.edit),
            onTap: () => _editLabel(context, ref, item.id, item.label),
          );
        },
      ),
    );
  }

  Future<void> _editLabel(
    BuildContext context,
    WidgetRef ref,
    String id,
    String current,
  ) async {
    final ctrl = TextEditingController(text: current);
    final label = await showDialog<String>(
      context: context,
      builder:
          (c) => AlertDialog(
            title: const Text('Podaj etykietę'),
            content: TextField(controller: ctrl, autofocus: true),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c),
                child: const Text('Anuluj'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(c, ctrl.text),
                child: const Text('OK'),
              ),
            ],
          ),
    );
    if (label != null) {
      ref.read(dataProvider.notifier).updateLabel(id, label);
    }
  }
}
