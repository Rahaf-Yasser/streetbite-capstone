import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/firestore_service.dart';
import 'package:flutter_app/data/models/profile_model.dart';

class ProfileDataSource {
  static const int _maxPhotoBytes = 700 * 1024;

  final FirebaseAuth _auth;
  final FirestoreService _firestore;

  ProfileDataSource(this._auth, this._firestore);

  /// Live stream of the signed-in user's profile document.
  Stream<ProfileModel> watchProfile() {
    final user = _auth.currentUser;
    if (user == null) {
      return Stream.error(StateError('No signed-in user'));
    }
    return _firestore.watchDocument('users/${user.uid}').map((data) {
      // Accounts created before Firestore was added have no document yet,
      // so fall back to the data stored in Firebase Auth.
      if (data == null) {
        return ProfileModel(
          fullName: user.displayName ?? '',
          email: user.email ?? '',
        );
      }
      return ProfileModel.fromJson(data);
    });
  }

  /// Saves the photo (as base64 text) in the user's Firestore document.
  Future<void> updatePhoto(Uint8List bytes) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('No signed-in user');
    }
    if (bytes.length > _maxPhotoBytes) {
      throw StateError('Photo is too large');
    }
    await _firestore.setDocument(
      'users/${user.uid}',
      {'photoBase64': base64Encode(bytes)},
    );
  }
}