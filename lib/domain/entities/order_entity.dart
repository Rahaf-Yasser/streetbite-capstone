import 'package:equatable/equatable.dart';

// SOLID Principle: Strategy Pattern Interface for Payment
abstract class PaymentMethod {
  String get type;
  Map<String, dynamic> toJson();
}

class CashPayment implements PaymentMethod {
  @override
  String get type => 'cash';

  @override
  Map<String, dynamic> toJson() => {'type': type};
}

class CardPayment implements PaymentMethod {
  final String cardLastFourDigits;
  CardPayment({required this.cardLastFourDigits});

  @override
  String get type => 'card';

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'cardLastFourDigits': cardLastFourDigits,
      };
}

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String restaurantName;
  final double total;
  final String status;
  final PaymentMethod paymentMethod;
  final DateTime? createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.restaurantName,
    required this.total,
    required this.status,
    required this.paymentMethod,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        restaurantName,
        total,
        status,
        paymentMethod,
        createdAt,
      ];
}