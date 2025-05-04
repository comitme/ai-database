// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataItemAdapter extends TypeAdapter<DataItem> {
  @override
  final int typeId = 1;

  @override
  DataItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataItem(
      id: fields[0] as String,
      path: fields[1] as String,
      label: fields[2] as String,
      synced: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DataItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.synced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
