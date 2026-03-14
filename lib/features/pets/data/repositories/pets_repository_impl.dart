import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/pets/data/datasources/pets_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/category_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/repositories/pets_repository.dart';

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
  Future<List<PetEntity>> getPets() async {
    try {
      final pets = await remoteDataSource.getPets();
      return pets.map((pet) => pet.toEntity()).toList(
            growable: false,
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
}
