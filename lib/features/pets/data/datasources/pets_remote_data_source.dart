import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/category_model.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/pet_model.dart';

abstract class PetsRemoteDataSource {
  Future<PaginatedPetsModel> getPets({required int page, required int limit});
  Future<List<CategoryModel>> getCategories();
  Future<PetModel> getPetById(String id);
}

class PaginatedPetsModel {
  final List<PetModel> pets;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const PaginatedPetsModel({
    required this.pets,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory PaginatedPetsModel.fromJson(Map<String, dynamic> json) {
    final rawPets = json['pets'];
    final rawPagination = json['pagination'];

    if (rawPets is! List || rawPagination is! Map) {
      throw const FormatException('Invalid paginated response.');
    }

    final petsList = rawPets
        .map((pet) => PetModel.fromJson(Map<String, dynamic>.from(pet as Map)))
        .toList();

    return PaginatedPetsModel(
      pets: petsList,
      total: rawPagination['total'] as int? ?? 0,
      page: rawPagination['page'] as int? ?? 1,
      limit: rawPagination['limit'] as int? ?? 10,
      totalPages: rawPagination['totalPages'] as int? ?? 1,
    );
  }
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
  Future<PaginatedPetsModel> getPets({required int page, required int limit}) async {
    final response = await apiClient.get('${_PetsEndpoints.pets}?page=$page&limit=$limit');

    try {
      return PaginatedPetsModel.fromJson(response);
    } on FormatException catch (error) {
      throw ParsingException(
        message: error.message,
      );
    } on TypeError {
      throw const ParsingException(message: 'Unable to parse pets.');
    }
  }

  @override
  Future<PetModel> getPetById(String id) async {
    final response = await apiClient.get('${_PetsEndpoints.petDetails}/$id');

    final Map<String, dynamic> petData;
    if (response.containsKey('pet')) {
      petData = Map<String, dynamic>.from(response['pet'] as Map);
    } else {
      petData = response;
    }

    try {
      return PetModel.fromJson(petData);
    } on FormatException catch (error) {
      throw ParsingException(message: error.message);
    } on TypeError {
      throw const ParsingException(message: 'Unable to parse pet details.');
    }
  }
}

class _PetsEndpoints {
  static const pets = '/pet/pets';
  static const categories = '/pet/category';
  static const petDetails = '/pet';
}
