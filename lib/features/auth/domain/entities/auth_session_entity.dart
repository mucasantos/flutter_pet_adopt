import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_user_entity.dart';
import 'package:flutter_pet_adopt/features/pets/domain/entities/pet_entity.dart';

class AuthSessionEntity extends Equatable {
  const AuthSessionEntity({
    required this.token,
    required this.user,
    required this.pets,
  });

  final String token;
  final AuthUserEntity user;
  final List<PetEntity> pets;

  @override
  List<Object?> get props => [token, user, pets];
}
