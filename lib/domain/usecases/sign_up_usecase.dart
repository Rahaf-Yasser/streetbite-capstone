import 'package:flutter_app/domain/entities/user_entity.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String password,
  }) =>
      _repository.signUp(
        fullName: fullName,
        email: email,
        password: password,
      );
}