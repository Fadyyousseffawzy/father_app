// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonModelAdapter extends TypeAdapter<PersonModel> {
  @override
  final int typeId = 0;

  @override
  PersonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonModel(
      name: fields[0] as String,
      adress: fields[1] as String,
      phone: fields[2] as String,
      work: fields[3] as String,
      row: fields[4] as String,
      info: fields[5] as String,
      barthday: fields[6] as String,
      lastdate: fields[7] as String,
      photo: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.adress)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.work)
      ..writeByte(4)
      ..write(obj.row)
      ..writeByte(5)
      ..write(obj.info)
      ..writeByte(6)
      ..write(obj.barthday)
      ..writeByte(7)
      ..write(obj.lastdate)
      ..writeByte(8)
      ..write(obj.photo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
