import 'package:flutter_app/data/datasources/user_collections_datasource.dart';
import 'package:flutter_app/domain/entities/favourite_entity.dart';
import 'package:flutter_app/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl implements FavouritesRepository {
  final UserCollectionsDataSource _dataSource;

  FavouritesRepositoryImpl(this._dataSource);

  @override
  Stream<List<FavouriteEntity>> watchFavourites() =>
      _dataSource.watchFavourites();
}