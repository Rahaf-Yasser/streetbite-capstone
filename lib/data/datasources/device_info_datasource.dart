import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_app/domain/entities/device_details_entity.dart';

class DeviceInfoDataSource {
  final DeviceInfoPlugin _plugin;

  DeviceInfoDataSource(this._plugin);

  Future<DeviceDetailsEntity> getDeviceDetails() async {
    final info = await _plugin.androidInfo;
    return DeviceDetailsEntity(
      model: '${info.manufacturer} ${info.model}',
      osVersion: 'Android ${info.version.release} (API ${info.version.sdkInt})',
    );
  }
}