import 'package:flutter_pet_adopt/models/category.dart';

class Pet {
  final String image;
  final String name;
  final String breed;
  final int age;
  final String gender;
  final Category category;
  final String place;

  Pet({
    required this.image,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.category,
    required this.place,
  });
}
