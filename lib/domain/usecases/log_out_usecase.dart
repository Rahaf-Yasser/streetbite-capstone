import 'package:flutter_app/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository _repository;

  LogOutUseCase(this._repository);

  Future<void> call() => _repository.logOut();
}