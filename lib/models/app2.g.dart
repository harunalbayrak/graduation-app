// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class App2Adapter extends TypeAdapter<App2> {
  @override
  final int typeId = 0;

  @override
  App2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return App2()
      ..appName = fields[0] as String
      ..packageName = fields[1] as String
      ..version = fields[2] as String
      ..allowWifi = fields[3] as bool
      ..allowMobileNetwork = fields[4] as bool
      ..isInWhitelist = fields[5] as bool
      ..notificationMode = fields[6] as bool
      ..totalActivities_7days = fields[7] as int
      ..icon = fields[8] as dynamic;
  }

  @override
  void write(BinaryWriter writer, App2 obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.appName)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.allowWifi)
      ..writeByte(4)
      ..write(obj.allowMobileNetwork)
      ..writeByte(5)
      ..write(obj.isInWhitelist)
      ..writeByte(6)
      ..write(obj.notificationMode)
      ..writeByte(7)
      ..write(obj.totalActivities_7days)
      ..writeByte(8)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is App2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
