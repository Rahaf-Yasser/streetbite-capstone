import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streetbite/presentation/blocs/cart/cart_event.dart';
import 'package:streetbite/presentation/blocs/cart/cart_item.dart';
import 'package:streetbite/presentation/blocs/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_onAddToCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final List<CartItem> current = List<CartItem>.from(state.items);
    final int index =
        current.indexWhere((item) => item.meal.id == event.meal.id);
    if (index >= 0) {
      current[index] =
          current[index].copyWith(quantity: current[index].quantity + 1);
    } else {
      current.add(CartItem(meal: event.meal, quantity: 1));
    }
    emit(state.copyWith(items: current));
  }
}
