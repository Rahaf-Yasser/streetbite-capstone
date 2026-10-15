import 'package:flutter_app/domain/entities/biometric_result.dart';
import 'package:flutter_app/domain/repositories/biometric_repository.dart';

class AuthenticateWithBiometricsUseCase {
  final BiometricRepository _repository;

  AuthenticateWithBiometricsUseCase(this._repository);

  Future<BiometricResult> call(String reason) =>
      _repository.authenticate(reason);
}