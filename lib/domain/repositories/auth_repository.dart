import 'package:flutter_app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> getCurrentUser();

  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserModel> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}