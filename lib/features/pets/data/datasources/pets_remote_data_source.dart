import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/category_model.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/pet_model.dart';

abstract class PetsRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<CategoryModel>> getCategories();
}

class PetsRemoteDataSourceImpl implements PetsRemoteDataSource {
  PetsRemoteDataSourceImpl({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.get(_PetsEndpoints.categories);
    final rawCategories = response['categories'];

    if (rawCategories is! List) {
      throw const ParsingException(message: 'Invalid categories response.');
    }

    try {
      return rawCategories
          .map(
            (category) => CategoryModel.fromJson(
              Map<String, dynamic>.from(category as Map),
            ),
          )
          .toList(growable: false);
    } on FormatException catch (error) {
      throw ParsingException(
        message: error.message,
      );
    } on TypeError {
      throw const ParsingException(message: 'Unable to parse categories.');
    }
  }

  @override
  Future<List<PetModel>> getPets() async {
    final response = await apiClient.get(_PetsEndpoints.pets);
    final rawPets = response['pets'];

    if (rawPets is! List) {
      throw const ParsingException(message: 'Invalid pets response.');
    }

    try {
      return rawPets
          .map(
            (pet) => PetModel.fromJson(
              Map<String, dynamic>.from(pet as Map),
            ),
          )
          .toList(growable: false);
    } on FormatException catch (error) {
      throw ParsingException(
        message: error.message,
      );
    } on TypeError {
      throw const ParsingException(message: 'Unable to parse pets.');
    }
  }
}

class _PetsEndpoints {
  static const pets = '/pet/pets';
  static const categories = '/pet/category';
}
