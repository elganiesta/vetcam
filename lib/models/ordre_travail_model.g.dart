// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordre_travail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdreTravailModelAdapter extends TypeAdapter<OrdreTravailModel> {
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
      ..demandeur = fields[3] as String
      ..unite = fields[4] as String
      ..types = (fields[5] as List).cast<dynamic>()
      ..travail = fields[6] as String
      ..pieces = (fields[7] as List).cast<dynamic>()
      ..commentaire = fields[8] as String
      ..status = fields[9] as String;
  }

  @override
  void write(BinaryWriter writer, OrdreTravailModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTimeDebut)
      ..writeByte(2)
      ..write(obj.dateTimeFin)
      ..writeByte(3)
      ..write(obj.demandeur)
      ..writeByte(4)
      ..write(obj.unite)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.travail)
      ..writeByte(7)
      ..write(obj.pieces)
      ..writeByte(8)
      ..write(obj.commentaire)
      ..writeByte(9)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdreTravailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
