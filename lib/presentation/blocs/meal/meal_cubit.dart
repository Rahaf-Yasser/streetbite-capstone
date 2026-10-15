import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_meals.dart';
import 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final GetMeals getMealsUseCase;

  MealCubit(this.getMealsUseCase) : super(MealInitial());

  Future<void> fetchMeals() async {
    emit(MealLoading());
    final result = await getMealsUseCase();
    
    if (result.error != null) {
      emit(MealError(result.error!.message, cachedMeals: result.meals));
    } else {
      emit(MealLoaded(result.meals));
    }
  }
}