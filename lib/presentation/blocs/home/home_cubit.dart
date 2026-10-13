import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/usecases/get_categories.dart';
import 'package:streetbite/domain/usecases/get_meals.dart';
import 'package:streetbite/presentation/blocs/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMeals getMeals;
  final GetCachedMeals getCachedMeals;
  final GetCategories getCategories;

  HomeCubit({
    required this.getMeals,
    required this.getCachedMeals,
    required this.getCategories,
  }) : super(const HomeState());

  Future<void> loadInitial() async {
    loadCategories();
    final cached = await getCachedMeals.call();
    if (cached.isNotEmpty) {
      emit(state.copyWith(
        status: HomeStatus.loaded,
        meals: cached,
        isRefreshing: true,
      ));
      await _fetchRemote();
    } else {
      emit(state.copyWith(status: HomeStatus.loading));
      await _fetchRemote();
    }
  }

  Future<void> refresh() async {
    if (state.hasMeals) {
      emit(state.copyWith(isRefreshing: true));
    } else {
      emit(state.copyWith(status: HomeStatus.loading));
    }
    await _fetchRemote();
  }

  Future<void> loadCategories() async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    final result = await getCategories.call();
    if (result.categories.isNotEmpty) {
      emit(state.copyWith(
        categoryStatus: CategoryStatus.loaded,
        categories: result.categories,
      ));
    } else {
      emit(state.copyWith(categoryStatus: CategoryStatus.error));
    }
  }

  Future<void> _fetchRemote() async {
    final result = await getMeals.call();
    if (result.meals.isNotEmpty) {
      emit(state.copyWith(
        status: HomeStatus.loaded,
        meals: result.meals,
        error: result.error,
        isRefreshing: false,
      ));
    } else {
      emit(state.copyWith(
        status: HomeStatus.error,
        meals: const <Meal>[],
        error: result.error,
        isRefreshing: false,
      ));
    }
  }
}
