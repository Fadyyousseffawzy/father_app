import 'package:hive/hive.dart';

part 'person_model.g.dart';

@HiveType(typeId: 0)
class PersonModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String adress;
  @HiveField(2)
  String phone;
  @HiveField(3)
  String work;
  @HiveField(4)
  String row;
  @HiveField(5)
  String info;
  @HiveField(6)
  String barthday;
  @HiveField(7)
  String lastdate;
  @HiveField(8)
  String photo;

  PersonModel({
    required this.name,
    required this.adress,
    required this.phone,
    required this.work,
    required this.row,
    required this.info,
    required this.barthday,
    required this.lastdate,
    required this.photo,
  });
}
