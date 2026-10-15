import 'dart:typed_data';

import 'package:flutter_app/data/datasources/image_picker_datasource.dart';
import 'package:flutter_app/domain/repositories/photo_picker_repository.dart';

class PhotoPickerRepositoryImpl implements PhotoPickerRepository {
  final ImagePickerDataSource _dataSource;

  PhotoPickerRepositoryImpl(this._dataSource);

  @override
  Future<Uint8List?> pickFromGallery() => _dataSource.pickFromGallery();
}