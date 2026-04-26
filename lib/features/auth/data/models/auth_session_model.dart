import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/auth/data/models/auth_user_model.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';

class AuthSessionModel extends Equatable {
  const AuthSessionModel({
    required this.token,
    required this.user,
  });

  final String token;
  final AuthUserModel user;

  factory AuthSessionModel.fromJson(
    Map<String, dynamic> json, {
    required String fallbackEmail,
  }) {
    final token = _extractToken(json);
    if (token == null) {
      throw const FormatException('Authentication token is missing.');
    }

    final rawUser = _extractUser(json);
    if (rawUser == null) {
      debugPrint('AUTH_DEBUG: rawUser não encontrado no JSON da sessão. Chaves: ${json.keys}');
    }
    
    final user = rawUser == null
        ? AuthUserModel.fallback(
            email: fallbackEmail,
          )
        : AuthUserModel.fromJson(rawUser, fallbackEmail: fallbackEmail);

    return AuthSessionModel(
      token: token,
      user: user,
    );
  }

  factory AuthSessionModel.fromStoredJson(Map<String, dynamic> json) {
    final token = _extractToken(json);
    final rawUser = json['user'];

    if (token == null || rawUser is! Map<String, dynamic>) {
      throw const FormatException('Stored session is invalid.');
    }

    return AuthSessionModel(
      token: token,
      user: AuthUserModel.fromJson(rawUser),
    );
  }

  AuthSessionEntity toEntity() {
    return AuthSessionEntity(
      token: token,
      user: user.toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  List<Object?> get props => [token, user];
}

String? _extractToken(Map<String, dynamic> json) {
  final directToken = json['token'] ?? json['accessToken'] ?? json['jwt'];
  if (directToken != null) {
    final value = directToken.toString().trim();
    return value.isEmpty ? null : value;
  }

  final data = json['data'];
  if (data is Map<String, dynamic>) {
    return _extractToken(data);
  }

  return null;
}

Map<String, dynamic>? _extractUser(Map<String, dynamic> json) {
  final rawUser = json['user'] ?? json['currentUser'] ?? json['profile'];
  if (rawUser is Map<String, dynamic>) {
    return rawUser;
  }

  final data = json['data'];
  if (data is Map<String, dynamic>) {
    final nestedUser = _extractUser(data);
    if (nestedUser != null) {
      return nestedUser;
    }

    if (data.containsKey('email') || data.containsKey('name')) {
      return data;
    }
  }

  if (json.containsKey('email') ||
      json.containsKey('mail') ||
      json.containsKey('name') ||
      json.containsKey('userId') ||
      json.containsKey('uid') ||
      json.containsKey('id')) {
    return json;
  }

  return null;
}
