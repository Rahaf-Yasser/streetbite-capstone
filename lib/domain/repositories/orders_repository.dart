import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<void> placeOrder(String userId, OrderEntity order);
  Stream<List<OrderEntity>> watchOrders(String userId);
}