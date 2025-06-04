import 'package:hive/hive.dart';
part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  String first_name;

  @HiveField(1)
  String? second_name;

  @HiveField(2)
  String? surname;

  @HiveField(3)
  int? country_id;

  @HiveField(4)
  String company;

  @HiveField(5)
  String? job_title;

  @HiveField(6)
  String? phone;

  @HiveField(7)
  String email;

  @HiveField(8)
  String? photo;

  @HiveField(9)
  String? country_code;

  Person({
    required this.first_name,
    this.second_name,
    this.surname,
    this.country_code,
    required this.company,
    this.job_title,
    this.phone,
    required this.email,
    this.photo,
    this.country_id,
  });
}
