import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_user_entity.dart';

class AuthSessionEntity extends Equatable {
  const AuthSessionEntity({
    required this.token,
    required this.user,
  });

  final String token;
  final AuthUserEntity user;

  @override
  List<Object?> get props => [token, user];
}
