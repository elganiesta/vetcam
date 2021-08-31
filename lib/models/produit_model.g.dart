// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProduitModelAdapter extends TypeAdapter<ProduitModel> {
  @override
  final int typeId = 5;

  @override
  ProduitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProduitModel()
      ..id = fields[0] as String
      ..nom = fields[1] as String
      ..type = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, ProduitModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProduitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
