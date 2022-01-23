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
      ..host = fields[1] as String
      ..ip = fields[2] as String
      ..times = (fields[3] as List).cast<DateTime>()
      ..isBlocked = fields[4] as bool
      ..total_1day = fields[5] as int
      ..total_7days = fields[6] as int
      ..appIcon = fields[7] as dynamic;
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.application)
      ..writeByte(1)
      ..write(obj.host)
      ..writeByte(2)
      ..write(obj.ip)
      ..writeByte(3)
      ..write(obj.times)
      ..writeByte(4)
      ..write(obj.isBlocked)
      ..writeByte(5)
      ..write(obj.total_1day)
      ..writeByte(6)
      ..write(obj.total_7days)
      ..writeByte(7)
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
