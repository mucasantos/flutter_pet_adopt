import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/paginated_pets.dart';

abstract class PetsRepository {
  Future<PaginatedPets> getPets({required int page, required int limit});
  Future<List<CategoryEntity>> getCategories();
}
