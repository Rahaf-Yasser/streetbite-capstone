import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/device_details_entity.dart';
import 'package:flutter_app/domain/entities/profile_entity.dart';

enum ProfileStatus { loading, loaded, failure }

enum PhotoError { pickFailed, uploadFailed }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileEntity? profile;
  final DeviceDetailsEntity? device;
  final bool deviceFailed;
  final bool isUpdatingPhoto;
  final PhotoError? photoError;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.profile,
    this.device,
    this.deviceFailed = false,
    this.isUpdatingPhoto = false,
    this.photoError,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileEntity? profile,
    DeviceDetailsEntity? device,
    bool? deviceFailed,
    bool? isUpdatingPhoto,
    PhotoError? photoError,
    bool clearPhotoError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      device: device ?? this.device,
      deviceFailed: deviceFailed ?? this.deviceFailed,
      isUpdatingPhoto: isUpdatingPhoto ?? this.isUpdatingPhoto,
      photoError: clearPhotoError ? null : (photoError ?? this.photoError),
    );
  }

  @override
  List<Object?> get props => [
        status,
        profile,
        device,
        deviceFailed,
        isUpdatingPhoto,
        photoError,
      ];
}