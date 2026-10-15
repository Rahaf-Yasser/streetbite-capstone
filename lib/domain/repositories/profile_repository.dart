import 'dart:typed_data';

import 'package:flutter_app/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Stream<ProfileEntity> watchProfile();

  Future<void> updatePhoto(Uint8List bytes);
}