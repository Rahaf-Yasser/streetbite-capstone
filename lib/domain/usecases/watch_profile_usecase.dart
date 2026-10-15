import 'package:flutter_app/domain/entities/profile_entity.dart';
import 'package:flutter_app/domain/repositories/profile_repository.dart';

class WatchProfileUseCase {
  final ProfileRepository _repository;

  WatchProfileUseCase(this._repository);

  Stream<ProfileEntity> call() => _repository.watchProfile();
}