import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class PlaceOrderUseCase {
  final OrderRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<void> call(String userId, OrderEntity order) {
    return repository.placeOrder(userId, order);
  }
}