import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';

abstract class AuthRepository {
  Future<AuthSessionEntity> login({
    required String email,
    required String password,
  });

  Future<AuthSessionEntity?> getSavedSession();

  Future<void> logout();
}
