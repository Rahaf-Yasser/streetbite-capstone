import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/domain/entities/cart_item.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_state.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  StreamSubscription<User?>? _authSub;
  String? _currentUid;

  CartBloc() : super(const CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
        _currentUid = FirebaseAuth.instance.currentUser?.uid;
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user?.uid != _currentUid) {
        _currentUid = user?.uid;
        add(ClearCartEvent());
      }
    });  
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

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final List<CartItem> current = List<CartItem>.from(state.items);
    final int index =
        current.indexWhere((item) => item.meal.id == event.mealId);

    if (index >= 0) {
      if (current[index].quantity > 1) {
        current[index] =
            current[index].copyWith(quantity: current[index].quantity - 1);
      } else {
        current.removeAt(index);
      }
    }

    emit(state.copyWith(items: current));
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }
    @override
  Future<void> close() {
    _authSub?.cancel();
    return super.close();
  }
}