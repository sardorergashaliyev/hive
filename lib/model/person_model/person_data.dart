import 'package:hive_flutter/adapters.dart';

part 'person_data.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final num count;
  @HiveField(2)
  final num gender;

  Person({required this.gender, required this.name, required this.count});

  factory Person.fromJson(Map data) {
    return Person(
        gender: data['gendet'], name: data['name'], count: data['count']);
  }
}
