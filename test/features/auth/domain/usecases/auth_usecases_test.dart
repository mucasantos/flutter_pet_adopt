import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/get_saved_session.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/login.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/logout.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;

  setUp(() {
    repository = MockAuthRepository();
  });

  test('Login delegates to repository with params', () async {
    final usecase = Login(repository);
    when(
      () => repository.login(
        email: 'samuel@example.com',
        password: '123456',
      ),
    ).thenAnswer((_) async => sampleAuthSession);

    final result = await usecase(
      const LoginParams(
        email: 'samuel@example.com',
        password: '123456',
      ),
    );

    expect(result, sampleAuthSession);
  });

  test('GetSavedSession delegates to repository', () async {
    final usecase = GetSavedSession(repository);
    when(() => repository.getSavedSession())
        .thenAnswer((_) async => sampleAuthSession);

    final result = await usecase(const NoParams());

    expect(result, sampleAuthSession);
  });

  test('Logout delegates to repository', () async {
    final usecase = Logout(repository);
    when(() => repository.logout()).thenAnswer((_) async {});

    await usecase(const NoParams());

    verify(() => repository.logout()).called(1);
  });
}
