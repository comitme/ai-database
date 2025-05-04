import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'data_item.g.dart';

@HiveType(typeId: 1)
class DataItem extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String path;
  @HiveField(2)
  String label;
  @HiveField(3)
  bool synced;

  DataItem({
    required this.id,
    required this.path,
    this.label = '',
    this.synced = false,
  });

  factory DataItem.newLocal(String path) =>
      DataItem(id: const Uuid().v4(), path: path);
}
