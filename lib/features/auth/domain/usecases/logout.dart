import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';

class Logout implements UseCase<void, NoParams> {
  const Logout(this.repository);

  final AuthRepository repository;

  @override
  Future<void> call(NoParams params) {
    return repository.logout();
  }
}
