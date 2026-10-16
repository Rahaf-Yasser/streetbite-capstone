enum AuthErrorType { firebase, network, unknown }

/// The only error the auth layers throw upwards. The Cubit never sees
/// FirebaseAuthException or any other raw exception.
class AuthException implements Exception {
  final AuthErrorType type;
  final String? message;

  const AuthException(this.type, [this.message]);
}