import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/get_saved_session.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/login.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/logout.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_data.dart';

class MockLogin extends Mock implements Login {}

class MockGetSavedSession extends Mock implements GetSavedSession {}

class MockLogout extends Mock implements Logout {}

void main() {
  late MockLogin login;
  late MockGetSavedSession getSavedSession;
  late MockLogout logout;

  setUpAll(() {
    registerFallbackValue(
        const LoginParams(email: 'a@a.com', password: '123456'));
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    login = MockLogin();
    getSavedSession = MockGetSavedSession();
    logout = MockLogout();
  });

  AuthCubit buildCubit() {
    return AuthCubit(
      login: login,
      getSavedSession: getSavedSession,
      logout: logout,
    );
  }

  blocTest<AuthCubit, AuthState>(
    'restoreSession emits authenticated when session exists',
    build: () {
      when(() => getSavedSession(any()))
          .thenAnswer((_) async => sampleAuthSession);
      return buildCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [
      const AuthState(status: AuthStatus.checkingSession),
      const AuthState(
        status: AuthStatus.authenticated,
        session: sampleAuthSession,
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'restoreSession emits unauthenticated when session does not exist',
    build: () {
      when(() => getSavedSession(any())).thenAnswer((_) async => null);
      return buildCubit();
    },
    act: (cubit) => cubit.restoreSession(),
    expect: () => [
      const AuthState(status: AuthStatus.checkingSession),
      const AuthState(status: AuthStatus.unauthenticated),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'login emits submitting then authenticated',
    build: () {
      when(() => login(any())).thenAnswer((_) async => sampleAuthSession);
      return buildCubit();
    },
    act: (cubit) => cubit.login(
      email: 'samuel@example.com',
      password: '123456',
    ),
    expect: () => [
      const AuthState(status: AuthStatus.submitting),
      const AuthState(
        status: AuthStatus.authenticated,
        session: sampleAuthSession,
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'login emits failure when usecase throws',
    build: () {
      when(() => login(any())).thenThrow(
        const FailureException(ServerFailure('Invalid credentials')),
      );
      return buildCubit();
    },
    act: (cubit) => cubit.login(
      email: 'samuel@example.com',
      password: '123456',
    ),
    expect: () => [
      const AuthState(status: AuthStatus.submitting),
      const AuthState(
        status: AuthStatus.failure,
        message: 'Invalid credentials',
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'logout emits unauthenticated',
    build: () {
      when(() => logout(any())).thenAnswer((_) async {});
      return buildCubit();
    },
    seed: () => const AuthState(
      status: AuthStatus.authenticated,
      session: sampleAuthSession,
    ),
    act: (cubit) => cubit.logout(),
    expect: () => [
      const AuthState(status: AuthStatus.unauthenticated),
    ],
  );
}
