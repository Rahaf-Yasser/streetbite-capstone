import 'package:flutter/services.dart';
import 'package:flutter_app/domain/entities/biometric_result.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class BiometricDataSource {
  final LocalAuthentication _auth;

  BiometricDataSource(this._auth);

  /// Never throws: every failure is converted into a [BiometricResult].
  Future<BiometricResult> authenticate(String reason) async {
    try {
      if (!await _auth.isDeviceSupported()) {
        return BiometricResult.notAvailable;
      }
      final enrolled = await _auth.getAvailableBiometrics();
      if (enrolled.isEmpty) {
        return BiometricResult.notEnrolled;
      }
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return ok ? BiometricResult.success : BiometricResult.failed;
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.lockedOut:
        case auth_error.permanentlyLockedOut:
          return BiometricResult.lockedOut;
        case auth_error.notEnrolled:
          return BiometricResult.notEnrolled;
        case auth_error.notAvailable:
          return BiometricResult.notAvailable;
        default:
          return BiometricResult.error;
      }
    } catch (_) {
      return BiometricResult.error;
    }
  }
}