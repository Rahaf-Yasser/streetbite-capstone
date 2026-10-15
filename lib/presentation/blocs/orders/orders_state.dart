import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';

abstract class OrdersState {
  final List<Order> orders;
  const OrdersState(this.orders);
}

class OrdersInitial extends OrdersState {
  const OrdersInitial() : super(const []);
}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded(super.orders);
}