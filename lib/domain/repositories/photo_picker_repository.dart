import 'dart:typed_data';

abstract class PhotoPickerRepository {
  /// Returns the picked image bytes, or null if the user cancelled.
  Future<Uint8List?> pickFromGallery();
}