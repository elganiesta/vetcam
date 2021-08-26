// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matiere_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatiereModelAdapter extends TypeAdapter<MatiereModel> {
  @override
  final int typeId = 2;

  @override
  MatiereModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatiereModel()
      ..id = fields[0] as String
      ..code = fields[1] as String
      ..designation = fields[2] as String
      ..unite = fields[3] as String
      ..quantite = fields[4] as double
      ..prixU = fields[5] as double
      ..observation = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, MatiereModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.designation)
      ..writeByte(3)
      ..write(obj.unite)
      ..writeByte(4)
      ..write(obj.quantite)
      ..writeByte(5)
      ..write(obj.prixU)
      ..writeByte(6)
      ..write(obj.observation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatiereModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
