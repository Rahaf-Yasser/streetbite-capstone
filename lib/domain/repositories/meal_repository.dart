import 'package:flutter_app/core/errors/failures.dart';
import 'package:flutter_app/domain/entities/meal.dart';

abstract class MealRepository {
  Future<({List<Meal> meals, Failure? error})> getMeals();

  Future<List<Meal>> getCachedMeals();

  Future<void> saveFavouriteMeal(String userId, Meal meal);
}
