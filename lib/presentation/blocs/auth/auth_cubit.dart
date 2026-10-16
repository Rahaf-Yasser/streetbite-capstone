import 'package:flutter_app/domain/entities/auth_exception.dart';
import 'package:flutter_app/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_app/domain/usecases/log_in_usecase.dart';
import 'package:flutter_app/domain/usecases/log_out_usecase.dart';
import 'package:flutter_app/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetCurrentUserUseCase _getCurrentUser;
  final SignUpUseCase _signUp;
  final LogInUseCase _logIn;
  final LogOutUseCase _logOut;

  AuthCubit({
    required GetCurrentUserUseCase getCurrentUser,
    required SignUpUseCase signUp,
    required LogInUseCase logIn,
    required LogOutUseCase logOut,
  })  : _getCurrentUser = getCurrentUser,
        _signUp = signUp,
        _logIn = logIn,
        _logOut = logOut,
        super(const AuthInitial());

  AuthError _toError(Object error) => error is AuthException
      ? AuthError(error.type, error.message)
      : const AuthError(AuthErrorType.unknown);

  Future<void> checkAuthStatus() async {
    try {
      final user = await _getCurrentUser();
      emit(user == null ? const Unauthenticated() : Authenticated(user));
    } catch (_) {
      // If the session cannot be read, start from the Welcome screen.
      emit(const Unauthenticated());
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _signUp(
        fullName: fullName,
        email: email,
        password: password,
      );
      emit(AuthSignUpSuccess(user));
    } catch (e) {
      emit(_toError(e));
    }
  }

  Future<void> logIn({required String email, required String password}) async {
    emit(const AuthLoading());
    try {
      final user = await _logIn(email: email, password: password);
      emit(Authenticated(user));
    } catch (e) {
      emit(_toError(e));
    }
  }

  Future<void> logOut() async {
    try {
      await _logOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(_toError(e));
    }
  }
}