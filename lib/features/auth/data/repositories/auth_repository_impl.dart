import 'package:flutter_pet_adopt/core/error/exceptions.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';
import 'package:flutter_pet_adopt/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<AuthSessionEntity?> getSavedSession() async {
    try {
      final session = await localDataSource.getSavedSession();
      return session?.toEntity();
    } on ParsingException catch (error) {
      await localDataSource.clearSession();
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while restoring the session.'),
      );
    }
  }

  @override
  Future<AuthSessionEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await localDataSource.saveSession(session);
      return session.toEntity();
    } on ServerException catch (error) {
      throw FailureException(ServerFailure(error.message));
    } on ParsingException catch (error) {
      throw FailureException(ParsingFailure(error.message));
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while logging in.'),
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearSession();
    } catch (_) {
      throw const FailureException(
        UnknownFailure('Unexpected error while logging out.'),
      );
    }
  }
}
