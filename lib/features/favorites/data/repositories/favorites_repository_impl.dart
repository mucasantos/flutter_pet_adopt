import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/favorites/data/datasources/favorites_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl({
    required this.remoteDataSource,
  });

  final FavoritesRemoteDataSource remoteDataSource;

  @override
  Future<List<PetEntity>> getFavorites(String token) async {
    try {
      final models = await remoteDataSource.getFavorites(token);
      return models.map((m) => m.toEntity()).toList();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while fetching favorites.'),
      );
    }
  }

  @override
  Future<List<PetEntity>> addFavorite(String token, String petId) async {
    try {
      final models = await remoteDataSource.addFavorite(token, petId);
      return models.map((m) => m.toEntity()).toList();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while adding favorite.'),
      );
    }
  }

  @override
  Future<List<PetEntity>> removeFavorite(String token, String petId) async {
    try {
      final models = await remoteDataSource.removeFavorite(token, petId);
      return models.map((m) => m.toEntity()).toList();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while removing favorite.'),
      );
    }
  }
}
