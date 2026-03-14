import 'package:equatable/equatable.dart';

class PetEntity extends Equatable {
  const PetEntity({
    required this.id,
    required this.name,
    required this.images,
    this.age,
    this.weight,
    this.color,
    this.gender,
    this.breed,
    this.story,
    this.categoryId,
    this.categoryName,
    this.isVerified,
    this.available,
  });

  final String id;
  final String name;
  final List<String> images;
  final int? age;
  final int? weight;
  final String? color;
  final String? gender;
  final String? breed;
  final String? story;
  final String? categoryId;
  final String? categoryName;
  final bool? isVerified;
  final bool? available;

  String get primaryImage => images.isEmpty ? '' : images.first;

  @override
  List<Object?> get props => [
        id,
        name,
        images,
        age,
        weight,
        color,
        gender,
        breed,
        story,
        categoryId,
        categoryName,
        isVerified,
        available,
      ];
}
