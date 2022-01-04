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
    return Statistic(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[6] as int,
      fields[7] as int,
      fields[8] as int,
      fields[9] as int,
      fields[10] as int,
      fields[11] as int,
      fields[12] as int,
      fields[13] as int,
    );
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
