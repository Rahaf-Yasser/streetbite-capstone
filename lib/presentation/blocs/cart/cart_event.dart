import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/meal.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final Meal meal;

  const AddToCartEvent(this.meal);

  @override
  List<Object?> get props => [meal];
}

class RemoveFromCartEvent extends CartEvent {
  final String mealId;

  const RemoveFromCartEvent(this.mealId);

  @override
  List<Object?> get props => [mealId];
}

class ClearCartEvent extends CartEvent {}