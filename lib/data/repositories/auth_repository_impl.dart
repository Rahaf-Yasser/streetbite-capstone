import 'package:flutter_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_app/domain/entities/user_entity.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<UserEntity?> getCurrentUser() async => _dataSource.currentUser;

  @override
  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String password,
  }) =>
      _dataSource.signUp(fullName: fullName, email: email, password: password);

  @override
  Future<UserEntity> logIn({
    required String email,
    required String password,
  }) =>
      _dataSource.logIn(email: email, password: password);

  @override
  Future<void> logOut() => _dataSource.logOut();
}