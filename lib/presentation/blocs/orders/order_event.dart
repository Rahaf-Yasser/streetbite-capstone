import 'package:flutter_app/domain/entities/order.dart';

abstract class OrdersEvent {}

// Emitted when the signed-in user changes, before new data arrives
class ResetOrdersEvent extends OrdersEvent {}

// Fresh list from Firestore for [uid]
class OrdersUpdated extends OrdersEvent {
  final String? uid;
  final List<Order> orders;
  OrdersUpdated(this.uid, this.orders);
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