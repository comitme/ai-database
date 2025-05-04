import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:ai_data_preparer/models/data_item.dart';

final dataProvider = StateNotifierProvider<DataNotifier, List<DataItem>>((ref) {
  final box = Hive.box<DataItem>('items');
  return DataNotifier(box);
});

class DataNotifier extends StateNotifier<List<DataItem>> {
  DataNotifier(this._box) : super(_box.values.toList());
  final Box<DataItem> _box;

  void _refresh() => state = _box.values.toList();

  void add(DataItem item) {
    _box.put(item.id, item);
    _refresh();
  }

  void updateLabel(String id, String label) {
    final item = _box.get(id);
    if (item == null) return;
    item.label = label;
    item.save();
    _refresh();
  }

  void markSynced(String id) {
    final item = _box.get(id);
    if (item == null) return;
    item.synced = true;
    item.save();
    _refresh();
  }
}
