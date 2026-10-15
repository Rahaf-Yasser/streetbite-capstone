import 'package:flutter_app/domain/entities/biometric_result.dart';

abstract class BiometricRepository {
  Future<BiometricResult> authenticate(String reason);
}