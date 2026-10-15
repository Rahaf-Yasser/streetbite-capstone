import 'package:flutter_app/core/errors/failures.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/domain/repositories/meal_repository.dart';

class GetMeals {
  final MealRepository repository;

  GetMeals(this.repository);

  Future<({List<Meal> meals, Failure? error})> call() {
    return repository.getMeals();
  }
}

class GetCachedMeals {
  final MealRepository repository;

  GetCachedMeals(this.repository);

  Future<List<Meal>> call() {
    return repository.getCachedMeals();
  }
}
