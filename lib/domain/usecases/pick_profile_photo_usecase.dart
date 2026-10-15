import 'dart:typed_data';

import 'package:flutter_app/domain/repositories/photo_picker_repository.dart';

class PickProfilePhotoUseCase {
  final PhotoPickerRepository _repository;

  PickProfilePhotoUseCase(this._repository);

  Future<Uint8List?> call() => _repository.pickFromGallery();
}