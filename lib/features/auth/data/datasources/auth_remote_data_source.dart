import 'package:flutter/widgets.dart';
import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/network/api_client.dart';
import 'package:flutter_pet_adopt/features/auth/data/models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required this.apiClient,
  });

  final ApiClient apiClient;

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    debugPrint("AuthRemoteDataSourceImpl.login");
    debugPrint(email);
    debugPrint(password);
    debugPrint(_AuthEndpoints.login);
    final response = await apiClient.post(
      _AuthEndpoints.login,
      body: {
        'email': email.toLowerCase(),
        'password': password,
      },
    );
    debugPrint("AuthRemoteDataSourceImpl.login");
    debugPrint(response.toString());
    try {
      return AuthSessionModel.fromJson(
        response,
        fallbackEmail: email,
      );
    } on FormatException catch (error) {
      debugPrint("AuthRemoteDataSourceImpl.login");

      throw ParsingException(message: error.message);
    }
  }
}

class _AuthEndpoints {
  static const login = '/user/login';
}
