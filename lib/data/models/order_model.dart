import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';

class OrderItemModel {
  final String mealId;
  final String name;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.mealId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      mealId: json['mealId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'mealId': mealId,
        'name': name,
        'price': price,
        'quantity': quantity,
      };
}

class OrderModel {
  final String id;
  final String userId;
  final String restaurantName;
  final List<OrderItemModel> items;
  final double total;
  final PaymentMethod paymentMethod;
  final String status;
  final DateTime? createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.restaurantName,
    required this.items,
    required this.total,
    required this.paymentMethod,
    required this.status,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, [String? docId]) {
    final paymentData = json['paymentMethod'] as Map<String, dynamic>? ?? {};
    final paymentType = paymentData['type'] ?? 'cash';

    final PaymentMethod payment = paymentType == 'card'
        ? CardPayment(cardLastFourDigits: paymentData['cardLastFourDigits'] ?? '')
        : CashPayment();

    return OrderModel(
      id: docId ?? json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      restaurantName: json['restaurantName'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: payment,
      status: json['status'] as String? ?? 'pending',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : (json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'restaurantName': restaurantName,
        'items': items.map((item) => item.toJson()).toList(),
        'total': total,
        'paymentMethod': paymentMethod.toJson(),
        'status': status,
        'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      };

  /// Converts this model to a pure Domain Entity
  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      restaurantName: restaurantName,
      total: total,
      status: status,
      paymentMethod: paymentMethod,
      createdAt: createdAt,
    );
  }
}