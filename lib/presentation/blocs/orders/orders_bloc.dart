import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_event.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(const OrdersInitial()) {
    on<LoadOrders>((event, emit) {
      emit(OrdersLoaded(state.orders));
    });

    on<PlaceOrderEvent>((event, emit) {
      final updated = [event.order, ...state.orders];
      emit(OrdersLoaded(updated));
    });

    on<UpdateOrderStatusEvent>((event, emit) {
      final updated = state.orders
          .map((order) => order.id == event.orderId
              ? order.copyWith(status: event.status)
              : order)
          .toList();
      emit(OrdersLoaded(updated));
    });

    on<CancelOrderEvent>((event, emit) {
      final updated = state.orders
          .map((order) => order.id == event.orderId
              ? order.copyWith(status: OrderStatus.cancelled)
              : order)
          .toList();
      emit(OrdersLoaded(updated));
    });
  }
}