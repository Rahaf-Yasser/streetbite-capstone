import 'package:flutter_app/data/datasources/device_info_datasource.dart';
import 'package:flutter_app/domain/entities/device_details_entity.dart';
import 'package:flutter_app/domain/repositories/device_info_repository.dart';

class DeviceInfoRepositoryImpl implements DeviceInfoRepository {
  final DeviceInfoDataSource _dataSource;

  DeviceInfoRepositoryImpl(this._dataSource);

  @override
  Future<DeviceDetailsEntity> getDeviceDetails() =>
      _dataSource.getDeviceDetails();
}