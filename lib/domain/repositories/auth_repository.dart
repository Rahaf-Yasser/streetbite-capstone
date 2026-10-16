import 'package:flutter_app/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> getCurrentUser();

  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<UserEntity> logIn({
    required String email,
    required String password,
  });

  Future<void> logOut();
}