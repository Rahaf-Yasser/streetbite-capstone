import 'package:streetbite/data/models/meal_model.dart';

abstract class MealDataSource {
  Future<List<MealModel>> getMeals();
}

abstract class MealLocalDataSource extends MealDataSource {
  Future<void> cacheMeals(List<MealModel> meals);
}
