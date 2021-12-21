// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterAdapter extends TypeAdapter<Filter> {
  @override
  final int typeId = 0;

  @override
  Filter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Filter()
      ..name = fields[0] as String
      ..information = fields[1] as String
      ..icon = fields[2] as dynamic
      ..isEnable = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, Filter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.information)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.isEnable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
