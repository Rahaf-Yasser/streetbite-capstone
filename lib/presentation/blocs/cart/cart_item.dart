import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/meal.dart';

class CartItem extends Equatable {
  final Meal meal;
  final int quantity;

  const CartItem({
    required this.meal,
    required this.quantity,
  });

  double get totalPrice => meal.price * quantity;

  CartItem copyWith({Meal? meal, int? quantity}) {
    return CartItem(
      meal: meal ?? this.meal,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [meal, quantity];
}
