import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/cart_item.dart'; 

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const <CartItem>[]});

  int get totalQuantity =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}