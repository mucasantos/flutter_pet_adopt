import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_user_entity.dart';

class AuthUserModel extends Equatable {
  const AuthUserModel(
      {required this.userId,
      required this.name,
      required this.email,
      this.phone,
      this.imageUrl,
      this.isAdmin});

  final String userId;
  final String name;
  final String email;
  final String? phone;
  final String? imageUrl;
  final bool? isAdmin;

  factory AuthUserModel.fromJson(
    Map<String, dynamic> json, {
    String? fallbackEmail,
  }) {
    final emailVal = _stringOrNull(json['email'] ?? json['mail']);
    final usernameVal = _stringOrNull(json['username']);
    final email = emailVal ??
        (usernameVal != null && usernameVal.contains('@')
            ? usernameVal
            : null) ??
        fallbackEmail;

    if (email == null) {
      throw const FormatException('User email is missing.');
    }
    return AuthUserModel(
      userId: _stringOrNull(json['userId'] ?? json['id']) ?? email,
      name: _stringOrNull(
            json['name'] ??
                json['fullName'] ??
                json['fullname'] ??
                (usernameVal != null && !usernameVal.contains('@')
                    ? usernameVal
                    : null) ??
                json['username'] ??
                json['user'],
          ) ??
          _nameFromEmail(email),
      email: email,
      phone: _stringOrNull(json['phone']),
      imageUrl: _stringOrNull(json['image'] ?? json['avatar'] ?? json['photo']),
      isAdmin: json['isAdmin'] as bool?,
    );
  }

  factory AuthUserModel.fallback({
    required String email,
  }) {
    return AuthUserModel(
      userId: email,
      name: _nameFromEmail(email),
      email: email,
    );
  }

  AuthUserEntity toEntity() {
    return AuthUserEntity(
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      imageUrl: imageUrl,
      isAdmin: isAdmin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'image': imageUrl,
      'isAdmin': isAdmin,
    };
  }

  @override
  List<Object?> get props => [userId, name, email, phone, imageUrl, isAdmin];
}

String? _stringOrNull(dynamic value) {
  if (value == null) {
    return null;
  }

  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

String _nameFromEmail(String email) {
  final localPart = email.split('@').first.trim();
  if (localPart.isEmpty) {
    return 'Adopt Me User';
  }

  final normalized = localPart.replaceAll(RegExp(r'[._-]+'), ' ');
  return normalized.split(' ').where((part) => part.isNotEmpty).map((part) {
    final first = part.substring(0, 1).toUpperCase();
    final rest = part.length == 1 ? '' : part.substring(1).toLowerCase();
    return '$first$rest';
  }).join(' ');
}
