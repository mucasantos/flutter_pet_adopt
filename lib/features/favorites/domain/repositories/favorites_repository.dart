import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

abstract class FavoritesRepository {
  Future<List<PetEntity>> getFavorites(String token);
  Future<List<PetEntity>> addFavorite(String token, String petId);
  Future<List<PetEntity>> removeFavorite(String token, String petId);
}
