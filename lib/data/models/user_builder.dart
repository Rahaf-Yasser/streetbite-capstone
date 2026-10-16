import 'package:flutter_app/data/models/user_model.dart';

/// BUILDER PATTERN.
/// Where: the sign-up flow (AuthRemoteDataSource) and the conversion of a
/// Firebase user into a [UserModel].
/// Why: a user is created step by step through this builder, and only the
/// sign-up fields (full name and email) are set on construction. The other
/// fields (uid, photoUrl) are added later with copyWith, once Firebase has
/// created the account.
class UserBuilder {
  String? _fullName;
  String? _email;

  String? get fullName => _fullName;
  String? get email => _email;

  UserBuilder setFullName(String fullName) {
    _fullName = fullName;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserModel build() {
    if (_fullName == null || _email == null) {
      throw StateError('fullName and email are required');
    }
    return UserModel.fromBuilder(this);
  }
}