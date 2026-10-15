import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagePickerDataSource {
  final ImagePicker _picker;

  ImagePickerDataSource(this._picker);

  /// Opens the gallery. The size and quality limits keep the image small
  /// enough to be stored inside a Firestore document.
  Future<Uint8List?> pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 70,
    );
    if (file == null) return null;
    return file.readAsBytes();
  }
}