import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> saveTempFile(File file) async {
    final dir = await getApplicationDocumentsDirectory();
    final newPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
    return (await file.copy(newPath)).path;
  }
}
