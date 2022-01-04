// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 3;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity()
      ..application = fields[0] as String
      ..domain = fields[1] as String
      ..times = (fields[2] as List).cast<DateTime>()
      ..isBlocked = fields[3] as bool
      ..total_1day = fields[4] as int
      ..total_7days = fields[5] as int
      ..appIcon = fields[6] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.application)
      ..writeByte(1)
      ..write(obj.domain)
      ..writeByte(2)
      ..write(obj.times)
      ..writeByte(3)
      ..write(obj.isBlocked)
      ..writeByte(4)
      ..write(obj.total_1day)
      ..writeByte(5)
      ..write(obj.total_7days)
      ..writeByte(6)
      ..write(obj.appIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
