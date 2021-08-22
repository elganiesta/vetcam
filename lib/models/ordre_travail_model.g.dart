// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordre_travail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdreTravailAdapter extends TypeAdapter<OrdreTravailModel> {
  @override
  final int typeId = 0;

  @override
  OrdreTravailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdreTravailModel()
      ..id = fields[0] as String
      ..dateTimeDebut = fields[1] as String
      ..dateTimeFin = fields[2] as String
      ..demandeur = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, OrdreTravailModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTimeDebut)
      ..writeByte(2)
      ..write(obj.dateTimeFin)
      ..writeByte(3)
      ..write(obj.demandeur);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdreTravailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
