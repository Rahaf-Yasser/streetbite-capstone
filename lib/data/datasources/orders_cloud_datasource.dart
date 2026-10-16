import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter_app/core/services/firestore_service.dart';
import 'package:flutter_app/domain/entities/cart_item.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/domain/entities/order.dart';

class OrdersCloudDataSource {
  final FirestoreService _firestore;

  OrdersCloudDataSource(this._firestore);

  String _path(String uid) => 'users/$uid/orders';

  Future<void> saveOrder(String uid, Order order) => _firestore.setDocument(
        '${_path(uid)}/${order.id}',
        _toMap(uid, order),
        merge: false,
      );

  Stream<List<Order>> watchOrders(String uid) => _firestore
      .watchCollection(_path(uid), orderBy: 'createdAt', descending: true)
      .map((docs) => docs.map(_fromMap).toList());

  Future<void> updateStatus(String uid, String orderId, OrderStatus status) =>
      _firestore.setDocument(
        '${_path(uid)}/$orderId',
        {'status': status.name},
      );

  // Order -> Firestore. Includes the fields OrderModel (profile) reads:
  // userId, restaurantName, total, paymentMethod.type, status, createdAt, items.
  Map<String, dynamic> _toMap(String uid, Order order) {
    final isCash = order.paymentMethod == 'cashOnDelivery';
    return {
      'id': order.id,
      'userId': uid,
      'restaurantName': 'StreetBite',
      'total': order.total,
      'subtotal': order.subtotal,
      'deliveryFee': order.deliveryFee,
      'status': order.status.name,
      'paymentMethod': {
        'type': isCash ? 'cash' : 'card',
        if (!isCash) 'cardLastFourDigits': '',
      },
      'createdAt': Timestamp.fromDate(order.createdAt),
      'items': order.items
          .map((i) => {
                'mealId': i.meal.id,
                'name': i.meal.name,
                'price': i.meal.price,
                'quantity': i.quantity,
                'thumbnail': i.meal.thumbnail,
                'category': i.meal.category,
                'area': i.meal.area,
                'discountPercent': i.meal.discountPercent,
              })
          .toList(),
    };
  }

  // Firestore -> Order
  Order _fromMap(Map<String, dynamic> data) {
    final total = (data['total'] as num?)?.toDouble() ?? 0.0;
    final payment = data['paymentMethod'] as Map<String, dynamic>? ?? {};
    final createdAt = data['createdAt'];

    final items = (data['items'] as List<dynamic>? ?? []).map((raw) {
      final m = raw as Map<String, dynamic>;
      return CartItem(
        meal: Meal(
          id: m['mealId'] as String? ?? '',
          name: m['name'] as String? ?? '',
          category: m['category'] as String? ?? '',
          area: m['area'] as String? ?? '',
          thumbnail: m['thumbnail'] as String? ?? '',
          instructions: '', // not needed for order history
          price: (m['price'] as num?)?.toDouble() ?? 0.0,
          discountPercent: (m['discountPercent'] as num?)?.toInt() ?? 0,
        ),
        quantity: (m['quantity'] as num?)?.toInt() ?? 1,
      );
    }).toList();

    return Order(
      id: data['id'] as String? ?? '',
      items: items,
      subtotal: (data['subtotal'] as num?)?.toDouble() ?? total,
      deliveryFee: (data['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      total: total,
      paymentMethod:
          payment['type'] == 'card' ? 'creditDebitCard' : 'cashOnDelivery',
      status: OrderStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
    );
  }
}