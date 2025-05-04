import 'package:flutter/material.dart';
import 'package:ai_data_preparer/screens/capture_screen.dart';
import 'package:ai_data_preparer/screens/tag_screen.dart';
import 'package:ai_data_preparer/screens/sync_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('AI Data Preparer')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Tile(
          Icons.camera_alt,
          'Zrób zdjęcie / nagraj',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CaptureScreen()),
          ),
        ),
        _Tile(
          Icons.label,
          'Oznacz dane',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TagScreen()),
          ),
        ),
        _Tile(
          Icons.cloud_upload,
          'Synchronizuj',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SyncScreen()),
          ),
        ),
      ],
    ),
  );
}

class _Tile extends StatelessWidget {
  const _Tile(this.icon, this.title, this.onTap);
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
