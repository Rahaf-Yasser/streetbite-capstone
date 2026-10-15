import 'package:flutter_app/domain/entities/cart_item.dart';

enum OrderStatus {
  pending,
  preparing,
  onTheWay,
  delivered,
  cancelled,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  Order copyWith({OrderStatus? status}) => Order(
        id: id,
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        total: total,
        paymentMethod: paymentMethod,
        status: status ?? this.status,
        createdAt: createdAt,
      );
}