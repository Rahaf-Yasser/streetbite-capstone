import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.restaurantName,
    required super.total,
    required super.status,
    super.createdAt,
  });

  /// FACTORY CONSTRUCTOR: builds a model from a Firestore document map.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String? ?? '',
      restaurantName: json['restaurantName'] as String? ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'restaurantName': restaurantName,
        'total': total,
        'status': status,
        'createdAt': createdAt == null ? null : Timestamp.fromDate(createdAt!),
      };
}