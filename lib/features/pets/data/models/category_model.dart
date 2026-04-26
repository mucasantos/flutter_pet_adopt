import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final id = _asString(json['_id'] ?? json['id']);
    final name = _asString(json['name']);

    if (id == null || name == null) {
      throw const FormatException('Category id or name is missing.');
    }

    return CategoryModel(
      id: id,
      name: name,
      imageUrl: _asString(json['image']),
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      imageUrl: imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl];
}

String? _asString(dynamic value) {
  if (value == null) {
    return null;
  }

  final stringValue = value.toString().trim();
  return stringValue.isEmpty ? null : stringValue;
}
