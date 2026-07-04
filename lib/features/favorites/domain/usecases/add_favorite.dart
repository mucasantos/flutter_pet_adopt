import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class AddFavorite implements UseCase<List<PetEntity>, FavoriteParams> {
  const AddFavorite(this.repository);

  final FavoritesRepository repository;

  @override
  Future<List<PetEntity>> call(FavoriteParams params) {
    return repository.addFavorite(params.token, params.petId);
  }
}

class FavoriteParams extends Equatable {
  const FavoriteParams({
    required this.token,
    required this.petId,
  });

  final String token;
  final String petId;

  @override
  List<Object?> get props => [token, petId];
}
