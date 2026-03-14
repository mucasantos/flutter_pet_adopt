import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

abstract class PetsRepository {
  Future<List<PetEntity>> getPets();
  Future<List<CategoryEntity>> getCategories();
}
