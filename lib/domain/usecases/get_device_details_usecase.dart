import 'package:flutter_app/domain/entities/device_details_entity.dart';
import 'package:flutter_app/domain/repositories/device_info_repository.dart';

class GetDeviceDetailsUseCase {
  final DeviceInfoRepository _repository;

  GetDeviceDetailsUseCase(this._repository);

  Future<DeviceDetailsEntity> call() => _repository.getDeviceDetails();
}