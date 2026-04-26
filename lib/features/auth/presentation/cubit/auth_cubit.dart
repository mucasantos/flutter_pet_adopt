import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pet_adopt/core/error/failures.dart';
import 'package:flutter_pet_adopt/core/usecase/usecase.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/get_saved_session.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/login.dart';
import 'package:flutter_pet_adopt/features/auth/domain/usecases/logout.dart';
import 'package:flutter_pet_adopt/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required Login login,
    required GetSavedSession getSavedSession,
    required Logout logout,
  })  : _login = login,
        _getSavedSession = getSavedSession,
        _logout = logout,
        super(const AuthState());

  final Login _login;
  final GetSavedSession _getSavedSession;
  final Logout _logout;

  Future<void> restoreSession() async {
    emit(
      state.copyWith(
        status: AuthStatus.checkingSession,
        message: null,
      ),
    );

    try {
      final session = await _getSavedSession(const NoParams());
      if (session == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
        return;
      }

      emit(
        AuthState(
          status: AuthStatus.authenticated,
          session: session,
        ),
      );
    } on FailureException catch (error) {
      emit(
        AuthState(
          status: AuthStatus.unauthenticated,
          message: error.failure.message,
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.submitting,
        message: null,
      ),
    );

    try {
      final session = await _login(
        LoginParams(
          email: email,
          password: password,
        ),
      );

      emit(
        AuthState(
          status: AuthStatus.authenticated,
          session: session,
        ),
      );
    } on FailureException catch (error) {
      emit(
        AuthState(
          status: AuthStatus.failure,
          message: error.failure.message,
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _logout(const NoParams());
      emit(const AuthState(status: AuthStatus.unauthenticated));
    } on FailureException catch (error) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: error.failure.message,
        ),
      );
    }
  }
}
