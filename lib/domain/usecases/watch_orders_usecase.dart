import 'package:flutter_app/domain/entities/order_entity.dart';
import 'package:flutter_app/domain/repositories/orders_repository.dart';

class WatchOrdersUseCase {
  final OrderRepository _repository;

  WatchOrdersUseCase(this._repository);

  Stream<List<OrderEntity>> call(String userId) => _repository.watchOrders(userId);
}