// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticAdapter extends TypeAdapter<Statistic> {
  @override
  final int typeId = 2;

  @override
  Statistic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Statistic()
      ..totalMN = fields[0] as int
      ..totalTE = fields[1] as int
      ..totalWD = fields[2] as int
      ..totalTU = fields[3] as int
      ..totalFR = fields[4] as int
      ..totalST = fields[5] as int
      ..totalSN = fields[6] as int
      ..blockedMN = fields[7] as int
      ..blockedTE = fields[8] as int
      ..blockedWD = fields[9] as int
      ..blockedTU = fields[10] as int
      ..blockedFR = fields[11] as int
      ..blockedST = fields[12] as int
      ..blockedSN = fields[13] as int;
  }

  @override
  void write(BinaryWriter writer, Statistic obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.totalMN)
      ..writeByte(1)
      ..write(obj.totalTE)
      ..writeByte(2)
      ..write(obj.totalWD)
      ..writeByte(3)
      ..write(obj.totalTU)
      ..writeByte(4)
      ..write(obj.totalFR)
      ..writeByte(5)
      ..write(obj.totalST)
      ..writeByte(6)
      ..write(obj.totalSN)
      ..writeByte(7)
      ..write(obj.blockedMN)
      ..writeByte(8)
      ..write(obj.blockedTE)
      ..writeByte(9)
      ..write(obj.blockedWD)
      ..writeByte(10)
      ..write(obj.blockedTU)
      ..writeByte(11)
      ..write(obj.blockedFR)
      ..writeByte(12)
      ..write(obj.blockedST)
      ..writeByte(13)
      ..write(obj.blockedSN);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
