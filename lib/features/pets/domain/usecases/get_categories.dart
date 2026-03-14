import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

class GetCategories implements UseCase<List<CategoryEntity>, NoParams> {
  const GetCategories(this.repository);

  final PetsRepository repository;

  @override
  Future<List<CategoryEntity>> call(NoParams params) {
    return repository.getCategories();
  }
}
