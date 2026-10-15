import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class SaveFavouriteUseCase {
  final MealRepository repository;

  SaveFavouriteUseCase(this.repository);

  Future<void> call(String userId, Meal meal) {
    return repository.saveFavouriteMeal(userId, meal);
  }
}