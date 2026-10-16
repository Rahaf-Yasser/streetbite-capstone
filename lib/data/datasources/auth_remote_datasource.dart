import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/firestore_service.dart';
import 'package:flutter_app/data/models/user_builder.dart';
import 'package:flutter_app/data/models/user_model.dart';
import 'package:flutter_app/domain/entities/auth_exception.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final FirestoreService _firestore;

  AuthRemoteDataSource(this._auth, this._firestore);

  UserModel _fromFirebase(User user) {
    return UserBuilder()
        .setFullName(user.displayName ?? '')
        .setEmail(user.email ?? '')
        .build()
        .copyWith(uid: user.uid, photoUrl: user.photoURL);
  }

  UserModel? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _fromFirebase(user);
  }

  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  }) =>
      _guard(() async {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await credential.user!.updateDisplayName(fullName);
        final user = UserBuilder()
            .setFullName(fullName)
            .setEmail(email)
            .build()
            .copyWith(uid: credential.user!.uid);
        try {
          await _firestore.setDocument('users/${user.uid}', user.toJson());
        } catch (_) {
          // The account already exists, so sign-up must not fail here.
          // The profile document is read from Firebase Auth until it exists.
        }
        return user;
      });

  Future<UserModel> logIn({
    required String email,
    required String password,
  }) =>
      _guard(() async {
        final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return _fromFirebase(credential.user!);
      });

  Future<void> logOut() => _guard(_auth.signOut);

  /// Turns every possible failure into an [AuthException].
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw const AuthException(AuthErrorType.network);
      }
      throw AuthException(AuthErrorType.firebase, e.message ?? e.code);
    } catch (_) {
      throw const AuthException(AuthErrorType.unknown);
    }
  }
}