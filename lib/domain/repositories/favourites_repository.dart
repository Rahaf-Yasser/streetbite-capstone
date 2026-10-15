import 'package:flutter_app/domain/entities/favourite_entity.dart';

abstract class FavouritesRepository {
  Stream<List<FavouriteEntity>> watchFavourites();
}