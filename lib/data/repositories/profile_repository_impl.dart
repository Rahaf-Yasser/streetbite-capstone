import 'dart:typed_data';

import 'package:flutter_app/data/datasources/profile_datasource.dart';
import 'package:flutter_app/domain/entities/profile_entity.dart';
import 'package:flutter_app/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Stream<ProfileEntity> watchProfile() => _dataSource.watchProfile();

  @override
  Future<void> updatePhoto(Uint8List bytes) => _dataSource.updatePhoto(bytes);
}