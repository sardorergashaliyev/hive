import 'package:hive_flutter/adapters.dart';

part 'person_data.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final num age;

  Person({required this.name, required this.age});
}
