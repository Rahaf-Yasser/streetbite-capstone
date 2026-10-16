import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/auth_exception.dart';
import 'package:flutter_app/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final UserEntity user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSignUpSuccess extends AuthState {
  final UserEntity user;
  const AuthSignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  final AuthErrorType type;
  final String? message;
  const AuthError(this.type, [this.message]);

  @override
  List<Object?> get props => [type, message];
}