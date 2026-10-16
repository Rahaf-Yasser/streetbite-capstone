import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(const AuthInitial());

  Future<void> checkAuthStatus() async {
    final user = await _repository.getCurrentUser();
    emit(user == null ? const Unauthenticated() : Authenticated(user));
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _repository.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );
      emit(AuthSignUpSuccess(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? e.code));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final user = await _repository.logIn(email: email, password: password);
      emit(Authenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? e.code));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logOut() async {
    await _repository.logOut();
    emit(const Unauthenticated());
  }
}