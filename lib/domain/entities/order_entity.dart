import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String restaurantName;
  final double total;
  final String status;
  final DateTime? createdAt;

  const OrderEntity({
    required this.id,
    required this.restaurantName,
    required this.total,
    required this.status,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, restaurantName, total, status, createdAt];
}