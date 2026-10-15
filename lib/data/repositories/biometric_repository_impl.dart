import 'package:flutter_app/data/datasources/biometric_datasource.dart';
import 'package:flutter_app/domain/entities/biometric_result.dart';
import 'package:flutter_app/domain/repositories/biometric_repository.dart';

class BiometricRepositoryImpl implements BiometricRepository {
  final BiometricDataSource _dataSource;

  BiometricRepositoryImpl(this._dataSource);

  @override
  Future<BiometricResult> authenticate(String reason) =>
      _dataSource.authenticate(reason);
}