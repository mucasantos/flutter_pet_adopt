import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/pets/data/models/pet_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<PetModel>> getFavorites(String token);
  Future<List<PetModel>> addFavorite(String token, String petId);
  Future<List<PetModel>> removeFavorite(String token, String petId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  const FavoritesRemoteDataSourceImpl({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<List<PetModel>> getFavorites(String token) async {
    final response = await apiClient.get(
      _FavoritesEndpoints.base,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return _parseFavorites(response);
  }

  @override
  Future<List<PetModel>> addFavorite(String token, String petId) async {
    final response = await apiClient.post(
      '${_FavoritesEndpoints.base}/$petId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return _parseFavorites(response);
  }

  @override
  Future<List<PetModel>> removeFavorite(String token, String petId) async {
    final response = await apiClient.delete(
      '${_FavoritesEndpoints.base}/$petId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return _parseFavorites(response);
  }

  List<PetModel> _parseFavorites(Map<String, dynamic> response) {
    final data = response['data'] is Map<String, dynamic> ? response['data'] : response;
    final rawFavorites = data['favorites'];

    if (rawFavorites is! List) {
      throw const ParsingException(message: 'Invalid favorites response.');
    }

    try {
      return rawFavorites
          .map(
            (pet) => PetModel.fromJson(
              Map<String, dynamic>.from(pet as Map),
            ),
          )
          .toList(growable: false);
    } on FormatException catch (error) {
      throw ParsingException(message: error.message);
    } on TypeError {
      throw const ParsingException(message: 'Unable to parse favorites.');
    }
  }
}

class _FavoritesEndpoints {
  static const base = '/favorites';
}
