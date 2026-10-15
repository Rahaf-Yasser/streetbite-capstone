import 'package:flutter_app/domain/entities/favourite_entity.dart';
import 'package:flutter_app/domain/usecases/watch_favourites_usecase.dart';
import 'package:flutter_app/presentation/blocs/live_list/live_list_cubit.dart';

class FavouritesCubit extends LiveListCubit<FavouriteEntity> {
  FavouritesCubit(WatchFavouritesUseCase useCase) : super(useCase.call);
}