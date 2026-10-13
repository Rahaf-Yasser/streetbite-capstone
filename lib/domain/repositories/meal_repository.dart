import 'package:streetbite/core/errors/failures.dart';
import 'package:streetbite/domain/entities/meal.dart';

abstract class MealRepository {
  Future<({List<Meal> meals, Failure? error})> getMeals();

  Future<List<Meal>> getCachedMeals();
}
