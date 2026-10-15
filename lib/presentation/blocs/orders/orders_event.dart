import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';

abstract class OrdersEvent {}

class LoadOrders extends OrdersEvent {}

class PlaceOrderEvent extends OrdersEvent {
  final Order order;
  PlaceOrderEvent(this.order);
}

class UpdateOrderStatusEvent extends OrdersEvent {
  final String orderId;
  final OrderStatus status;
  UpdateOrderStatusEvent(this.orderId, this.status);
}

class CancelOrderEvent extends OrdersEvent {
  final String orderId;
  CancelOrderEvent(this.orderId);
}