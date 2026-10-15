import 'package:flutter_app/data/datasources/user_collections_datasource.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../core/services/firestore_service.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirestoreService firestoreService;

  OrderRepositoryImpl(UserCollectionsDataSource userCollectionsDataSource, {required this.firestoreService});

  /// 1. Places a new order in Cloud Firestore
  @override
  Future<void> placeOrder(String userId, OrderEntity order) async {
    final model = OrderModel(
      id: order.id,
      userId: userId,
      restaurantName: order.restaurantName,
      items: const [], // Map order items if present
      total: order.total,
      paymentMethod: order.paymentMethod,
      status: order.status,
      createdAt: order.createdAt ?? DateTime.now(),
    );

    await firestoreService.saveOrder(userId, model.toJson());
  }

  /// 2. Listens to real-time order updates for the user
  @override
  Stream<List<OrderEntity>> watchOrders(String userId) {
    return firestoreService.watchOrders(userId);
  }
}