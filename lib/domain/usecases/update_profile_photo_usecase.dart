import 'dart:typed_data';

import 'package:flutter_app/domain/repositories/profile_repository.dart';

class UpdateProfilePhotoUseCase {
  final ProfileRepository _repository;

  UpdateProfilePhotoUseCase(this._repository);

  Future<void> call(Uint8List bytes) => _repository.updatePhoto(bytes);
}