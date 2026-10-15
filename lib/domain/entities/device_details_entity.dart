import 'package:equatable/equatable.dart';

class DeviceDetailsEntity extends Equatable {
  final String model;
  final String osVersion;

  const DeviceDetailsEntity({required this.model, required this.osVersion});

  @override
  List<Object?> get props => [model, osVersion];
}