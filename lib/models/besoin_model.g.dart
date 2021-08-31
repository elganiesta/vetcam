// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'besoin_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BesoinModelAdapter extends TypeAdapter<BesoinModel> {
  @override
  final int typeId = 4;

  @override
  BesoinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BesoinModel()
      ..id = fields[0] as String
      ..besoins = (fields[1] as List).cast<BesoinItem>()
      ..service = fields[2] as String
      ..date = fields[3] as String
      ..urgent = fields[4] as bool
      ..status = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, BesoinModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.besoins)
      ..writeByte(2)
      ..write(obj.service)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.urgent)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BesoinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
