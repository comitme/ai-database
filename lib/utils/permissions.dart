import 'package:permission_handler/permission_handler.dart';

Future<bool> ensurePhotoPermission() async {
  if (await Permission.photos.request().isGranted) {
    return true; // Android 13+, iOS
  }
  return await Permission.storage.request().isGranted; // Android ≤12
}
