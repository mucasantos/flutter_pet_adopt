import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late MockAuthLocalDataSource localDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    localDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
  });

  test('login persists the session and returns the entity', () async {
    when(
      () => remoteDataSource.login(
        email: 'samuel@example.com',
        password: '123456',
      ),
    ).thenAnswer((_) async => sampleAuthSessionModel);
    when(() => localDataSource.saveSession(sampleAuthSessionModel))
        .thenAnswer((_) async {});

    final result = await repository.login(
      email: 'samuel@example.com',
      password: '123456',
    );

    expect(result, sampleAuthSession);
    verify(
      () => localDataSource.saveSession(sampleAuthSessionModel),
    ).called(1);
  });

  test('getSavedSession translates parsing errors and clears storage',
      () async {
    when(() => localDataSource.getSavedSession()).thenThrow(
      const ParsingException(message: 'Stored session is invalid.'),
    );
    when(() => localDataSource.clearSession()).thenAnswer((_) async {});

    expect(
      repository.getSavedSession(),
      throwsA(
        isA<FailureException>().having(
          (error) => error.failure,
          'failure',
          const ParsingFailure('Stored session is invalid.'),
        ),
      ),
    );

    verify(() => localDataSource.clearSession()).called(1);
  });

  test('login translates server errors', () async {
    when(
      () => remoteDataSource.login(
        email: 'samuel@example.com',
        password: '123456',
      ),
    ).thenThrow(
      const ServerException(message: 'Unauthorized'),
    );

    expect(
      repository.login(
        email: 'samuel@example.com',
        password: '123456',
      ),
      throwsA(
        isA<FailureException>().having(
          (error) => error.failure,
          'failure',
          const ServerFailure('Unauthorized'),
        ),
      ),
    );
  });
}
