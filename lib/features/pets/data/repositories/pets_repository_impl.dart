import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/pets/data/datasources/pets_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

import 'package:flutter_pet_adopt/features/pets/domain/entities/paginated_pets.dart';

class PetsRepositoryImpl implements PetsRepository {
  const PetsRepositoryImpl({
    required this.remoteDataSource,
  });

  final PetsRemoteDataSource remoteDataSource;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return categories.map((category) => category.toEntity()).toList(
            growable: false,
          );
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while loading categories.'),
      );
    }
  }

  @override
  Future<PaginatedPets> getPets({required int page, required int limit}) async {
    try {
      final paginated = await remoteDataSource.getPets(page: page, limit: limit);
      return PaginatedPets(
        pets: paginated.pets.map((pet) => pet.toEntity()).toList(growable: false),
        total: paginated.total,
        page: paginated.page,
        limit: paginated.limit,
        totalPages: paginated.totalPages,
      );
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while loading pets.'),
      );
    }
  }

  @override
  Future<PetEntity> getPetById(String id) async {
    try {
      final petModel = await remoteDataSource.getPetById(id);
      return petModel.toEntity();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while loading pet details.'),
      );
    }
  }
}
