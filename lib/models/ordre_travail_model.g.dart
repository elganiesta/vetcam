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
      ..autreUnite = fields[5] as String?
      ..types = (fields[6] as List).cast<dynamic>()
      ..autreType = fields[7] as String?
      ..travail = fields[8] as String
      ..pieces = (fields[9] as List).cast<dynamic>()
      ..autrePiece = fields[10] as String?
      ..commentaire = fields[11] as String
      ..status = fields[12] as String
      ..intervenants = (fields[13] as List).cast<IntervenantModel>()
      ..matieres = (fields[14] as List).cast<MatiereModel>();
  }

  @override
  void write(BinaryWriter writer, OrdreTravailModel obj) {
    writer
      ..writeByte(15)
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
      ..write(obj.autreUnite)
      ..writeByte(6)
      ..write(obj.types)
      ..writeByte(7)
      ..write(obj.autreType)
      ..writeByte(8)
      ..write(obj.travail)
      ..writeByte(9)
      ..write(obj.pieces)
      ..writeByte(10)
      ..write(obj.autrePiece)
      ..writeByte(11)
      ..write(obj.commentaire)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.intervenants)
      ..writeByte(14)
      ..write(obj.matieres);
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
