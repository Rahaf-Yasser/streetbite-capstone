import 'package:flutter_app/domain/entities/device_details_entity.dart';

abstract class DeviceInfoRepository {
  Future<DeviceDetailsEntity> getDeviceDetails();
}