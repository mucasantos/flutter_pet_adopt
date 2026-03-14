import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class PetModel extends Equatable {
  const PetModel({
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

  factory PetModel.fromJson(Map<String, dynamic> json) {
    final id = _asString(json['_id'] ?? json['id']);
    final name = _asString(json['name']);

    if (id == null || name == null) {
      throw const FormatException('Pet id or name is missing.');
    }

    final category = json['category'];

    String? categoryId;
    String? categoryName;

    if (category is Map<String, dynamic>) {
      categoryId = _asString(category['_id'] ?? category['id']);
      categoryName = _asString(category['name']);
    }

    categoryId ??= _asString(
        json['categoryId'] ?? json['petCategoryId'] ?? json['typeId']);
    categoryName ??=
        _asString(json['categoryName'] ?? json['petType'] ?? json['type']);

    return PetModel(
      id: id,
      name: name,
      images: _asStringList(json['images']),
      age: _asInt(json['age']),
      weight: _asInt(json['weight']),
      color: _asString(json['color']),
      gender: _asString(json['gender']),
      breed: _asString(json['breed']),
      story: _asString(json['story']),
      categoryId: categoryId,
      categoryName: categoryName,
      isVerified: _asBool(json['isVerified']),
      available: _asBool(json['available']),
    );
  }

  PetEntity toEntity() {
    return PetEntity(
      id: id,
      name: name,
      images: images,
      age: age,
      weight: weight,
      color: color,
      gender: gender,
      breed: breed,
      story: story,
      categoryId: categoryId,
      categoryName: categoryName,
      isVerified: isVerified,
      available: available,
    );
  }

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

String? _asString(dynamic value) {
  if (value == null) {
    return null;
  }

  final stringValue = value.toString().trim();
  return stringValue.isEmpty ? null : stringValue;
}

int? _asInt(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString());
}

bool? _asBool(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is bool) {
    return value;
  }

  final normalized = value.toString().toLowerCase();
  if (normalized == 'true') {
    return true;
  }
  if (normalized == 'false') {
    return false;
  }

  return null;
}

List<String> _asStringList(dynamic value) {
  if (value is! List) {
    return const [];
  }

  return value
      .map((item) => _asString(item))
      .whereType<String>()
      .toList(growable: false);
}
