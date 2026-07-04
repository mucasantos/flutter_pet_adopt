import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class GetFavorites implements UseCase<List<PetEntity>, String> {
  const GetFavorites(this.repository);

  final FavoritesRepository repository;

  @override
  Future<List<PetEntity>> call(String token) {
    return repository.getFavorites(token);
  }
}
