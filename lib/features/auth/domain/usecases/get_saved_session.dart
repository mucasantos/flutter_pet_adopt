import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';

class GetSavedSession implements UseCase<AuthSessionEntity?, NoParams> {
  const GetSavedSession(this.repository);

  final AuthRepository repository;

  @override
  Future<AuthSessionEntity?> call(NoParams params) {
    return repository.getSavedSession();
  }
}
