import 'package:flutter_app/core/errors/exceptions.dart';
import 'package:flutter_app/core/errors/failures.dart';
import 'package:flutter_app/data/datasources/meal_data_source.dart';
import 'package:flutter_app/data/datasources/meal_data_source_factory.dart';
import 'package:flutter_app/data/models/meal_model.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealDataSourceFactory _dataSourceFactory;

  MealRepositoryImpl(this._dataSourceFactory);

  @override
  Future<({List<Meal> meals, Failure? error})> getMeals() async {
    try {
      final MealDataSource remote =
          _dataSourceFactory.create(DataSourceType.remote);
      final List<MealModel> models = await remote.getMeals();
      if (models.isNotEmpty) {
        await _cacheModels(models);
      }
      return (meals: _toEntities(models), error: null);
    } on ApiException catch (e) {
      final cached = await _safeReadCache();
      if (cached.isNotEmpty) {
        return (
          meals: _toEntities(cached),
          error: NetworkFailure(e.message),
        );
      }
      return (
        meals: const <Meal>[],
        error: NetworkFailure(e.message),
      );
    } on CacheException catch (e) {
      return (
        meals: const <Meal>[],
        error: CacheFailure(e.message),
      );
    } catch (e) {
      final cached = await _safeReadCache();
      if (cached.isNotEmpty) {
        return (
          meals: _toEntities(cached),
          error: UnknownFailure(e.toString()),
        );
      }
      return (
        meals: const <Meal>[],
        error: UnknownFailure(e.toString()),
      );
    }
  }
// I use the factory to get the data source
//If the API fails, I try to load the saved meals from local storage
  @override
  Future<List<Meal>> getCachedMeals() async {
    final cached = await _safeReadCache();
    return _toEntities(cached);
  }

  Future<void> _cacheModels(List<MealModel> models) async {
    try {
      final local = _dataSourceFactory.create(DataSourceType.local)
          as MealLocalDataSource;
      await local.cacheMeals(models);
    } catch (_) {}
  }

  Future<List<MealModel>> _safeReadCache() async {
    try {
      final MealDataSource local =
          _dataSourceFactory.create(DataSourceType.local);
      return await local.getMeals();
    } catch (_) {
      return const <MealModel>[];
    }
  }

  List<Meal> _toEntities(List<MealModel> models) {
    return models
        .map(
          (MealModel m) => Meal(
            id: m.id,
            name: m.name,
            category: m.category,
            area: m.area,
            thumbnail: m.thumbnail,
            instructions: m.instructions,
            price: m.computedPrice,
            discountPercent: m.computedDiscountPercent,
          ),
        )
        .toList();
  }
}
