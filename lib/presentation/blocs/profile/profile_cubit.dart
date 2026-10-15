import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_app/domain/entities/profile_entity.dart';
import 'package:flutter_app/domain/usecases/get_device_details_usecase.dart';
import 'package:flutter_app/domain/usecases/pick_profile_photo_usecase.dart';
import 'package:flutter_app/domain/usecases/update_profile_photo_usecase.dart';
import 'package:flutter_app/domain/usecases/watch_profile_usecase.dart';
import 'package:flutter_app/presentation/blocs/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final WatchProfileUseCase _watchProfile;
  final GetDeviceDetailsUseCase _getDeviceDetails;
  final PickProfilePhotoUseCase _pickPhoto;
  final UpdateProfilePhotoUseCase _updatePhoto;
  StreamSubscription<ProfileEntity>? _subscription;

  ProfileCubit(
    this._watchProfile,
    this._getDeviceDetails,
    this._pickPhoto,
    this._updatePhoto,
  ) : super(const ProfileState());

  Future<void> load() async {
    emit(state.copyWith(status: ProfileStatus.loading, deviceFailed: false));

    try {
      final device = await _getDeviceDetails();
      if (isClosed) return;
      emit(state.copyWith(device: device));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(deviceFailed: true));
    }

    await _subscription?.cancel();
    _subscription = _watchProfile().listen(
      (profile) {
        if (isClosed) return;
        emit(state.copyWith(status: ProfileStatus.loaded, profile: profile));
      },
      onError: (_) {
        if (isClosed) return;
        emit(state.copyWith(status: ProfileStatus.failure));
      },
    );
  }

  /// Picks a photo from the gallery and saves it to Firestore.
  /// The live profile stream then pushes the new photo to the screen.
  Future<void> changePhoto() async {
    if (state.isUpdatingPhoto) return;
    emit(state.copyWith(isUpdatingPhoto: true, clearPhotoError: true));

    Uint8List? bytes;
    try {
      bytes = await _pickPhoto();
    } catch (_) {
      _finishPhotoUpdate(PhotoError.pickFailed);
      return;
    }

    if (bytes == null) {
      // The user closed the gallery without choosing: not an error.
      _finishPhotoUpdate();
      return;
    }

    try {
      await _updatePhoto(bytes).timeout(const Duration(seconds: 15));
      _finishPhotoUpdate();
    } catch (_) {
      _finishPhotoUpdate(PhotoError.uploadFailed);
    }
  }

  void _finishPhotoUpdate([PhotoError? error]) {
    if (isClosed) return;
    emit(state.copyWith(isUpdatingPhoto: false, photoError: error));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}