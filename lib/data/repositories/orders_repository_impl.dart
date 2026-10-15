import 'package:flutter_app/data/datasources/user_collections_datasource.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';
import 'package:flutter_app/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final UserCollectionsDataSource _dataSource;

  OrdersRepositoryImpl(this._dataSource);

  @override
  Stream<List<OrderEntity>> watchOrders() => _dataSource.watchOrders();
}