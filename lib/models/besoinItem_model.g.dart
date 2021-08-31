// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'besoinItem_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BesoinItemAdapter extends TypeAdapter<BesoinItem> {
  @override
  final int typeId = 6;

  @override
  BesoinItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BesoinItem()
      ..numero = fields[0] as String
      ..designation = fields[1] as String
      ..quantite = fields[2] as String
      ..observation = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, BesoinItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.numero)
      ..writeByte(1)
      ..write(obj.designation)
      ..writeByte(2)
      ..write(obj.quantite)
      ..writeByte(3)
      ..write(obj.observation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BesoinItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
