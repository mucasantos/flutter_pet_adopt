import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/usecases/add_favorite.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class RemoveFavorite implements UseCase<List<PetEntity>, FavoriteParams> {
  const RemoveFavorite(this.repository);

  final FavoritesRepository repository;

  @override
  Future<List<PetEntity>> call(FavoriteParams params) {
    return repository.removeFavorite(params.token, params.petId);
  }
}
