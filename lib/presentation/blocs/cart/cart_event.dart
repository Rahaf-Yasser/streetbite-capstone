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
