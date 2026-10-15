import 'package:flutter_app/domain/entities/order_entity.dart';

abstract class OrdersRepository {
  Stream<List<OrderEntity>> watchOrders();
}