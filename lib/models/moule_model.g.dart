// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MouleModelAdapter extends TypeAdapter<MouleModel> {
  @override
  final int typeId = 3;

  @override
  MouleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MouleModel()
      ..id = fields[0] as String
      ..numero = fields[1] as String
      ..nom = fields[2] as String
      ..marque = fields[3] as String
      ..planches = fields[4] as double
      ..status = fields[5] as String
      ..reception = fields[6] as String
      ..miseEnService = fields[7] as String?
      ..derniereUtilisation = fields[8] as String?
      ..rebut = fields[9] as String?
      ..seuil = fields[10] as double
      ..unite = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, MouleModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.numero)
      ..writeByte(2)
      ..write(obj.nom)
      ..writeByte(3)
      ..write(obj.marque)
      ..writeByte(4)
      ..write(obj.planches)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.reception)
      ..writeByte(7)
      ..write(obj.miseEnService)
      ..writeByte(8)
      ..write(obj.derniereUtilisation)
      ..writeByte(9)
      ..write(obj.rebut)
      ..writeByte(10)
      ..write(obj.seuil)
      ..writeByte(11)
      ..write(obj.unite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MouleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
