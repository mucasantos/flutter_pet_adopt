import 'package:equatable/equatable.dart';
import 'package:flutter_pet_adopt/features/auth/domain/entities/auth_session_entity.dart';

enum AuthStatus {
  initial,
  checkingSession,
  submitting,
  authenticated,
  unauthenticated,
  failure,
}

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.session,
    this.message,
  });

  final AuthStatus status;
  final AuthSessionEntity? session;
  final String? message;

  bool get isAuthenticated =>
      status == AuthStatus.authenticated && session != null;

  AuthState copyWith({
    AuthStatus? status,
    Object? session = _sentinel,
    Object? message = _sentinel,
  }) {
    return AuthState(
      status: status ?? this.status,
      session: identical(session, _sentinel)
          ? this.session
          : session as AuthSessionEntity?,
      message:
          identical(message, _sentinel) ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => [status, session, message];
}

const _sentinel = Object();
