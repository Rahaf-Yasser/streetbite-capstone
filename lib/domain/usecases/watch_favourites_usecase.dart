import 'package:flutter_app/domain/entities/favourite_entity.dart';
import 'package:flutter_app/domain/repositories/favourites_repository.dart';

class WatchFavouritesUseCase {
  final FavouritesRepository _repository;

  WatchFavouritesUseCase(this._repository);

  Stream<List<FavouriteEntity>> call() => _repository.watchFavourites();
}