import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<AuthSessionEntity, LoginParams> {
  const Login(this.repository);

  final AuthRepository repository;

  @override
  Future<AuthSessionEntity> call(LoginParams params) {
    return repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
