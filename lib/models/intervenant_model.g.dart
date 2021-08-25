// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervenant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IntervenantModelAdapter extends TypeAdapter<IntervenantModel> {
  @override
  final int typeId = 1;

  @override
  IntervenantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IntervenantModel()
      ..id = fields[0] as String
      ..nom = fields[1] as String
      ..fonction = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, IntervenantModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.fonction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntervenantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
