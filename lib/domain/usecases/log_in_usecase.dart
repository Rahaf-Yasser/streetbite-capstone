import 'package:flutter_app/domain/entities/user_entity.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';

class LogInUseCase {
  final AuthRepository _repository;

  LogInUseCase(this._repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) =>
      _repository.logIn(email: email, password: password);
}