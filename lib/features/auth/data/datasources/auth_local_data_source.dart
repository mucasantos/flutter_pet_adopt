import 'dart:convert';

import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/features/auth/data/models/auth_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSavedSession();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Future<void> clearSession() async {
    await sharedPreferences.remove(_sessionKey);
  }

  @override
  Future<AuthSessionModel?> getSavedSession() async {
    final rawSession = sharedPreferences.getString(_sessionKey);
    if (rawSession == null || rawSession.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawSession);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Stored session is invalid.');
      }

      return AuthSessionModel.fromStoredJson(decoded);
    } on FormatException catch (error) {
      throw ParsingException(message: error.message);
    }
  }

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await sharedPreferences.setString(
      _sessionKey,
      jsonEncode(session.toJson()),
    );
  }
}

const _sessionKey = 'auth_session';
