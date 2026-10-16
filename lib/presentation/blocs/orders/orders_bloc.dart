import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/data/datasources/orders_cloud_datasource.dart';
import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/presentation/blocs/orders/order_event.dart';
import 'package:flutter_app/presentation/blocs/orders/order_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersCloudDataSource _cloud;
  StreamSubscription<User?>? _authSub;
  StreamSubscription<List<Order>>? _ordersSub;
  String? _currentUid;

  OrdersBloc(this._cloud) : super(const OrdersInitial()) {
    on<ResetOrdersEvent>((event, emit) => emit(const OrdersInitial()));

    on<OrdersUpdated>((event, emit) {
      if (event.uid != _currentUid) return; // stale data from a previous user
      emit(OrdersLoaded(event.orders));
    });

    on<CancelOrderEvent>(
      (event, emit) => _setStatus(event.orderId, OrderStatus.cancelled),
    );

    on<UpdateOrderStatusEvent>(
      (event, emit) => _setStatus(event.orderId, event.status),
    );

    _bindToUser(FirebaseAuth.instance.currentUser);
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user?.uid != _currentUid) _bindToUser(user);
    });
  }

  void _bindToUser(User? user) {
    final uid = user?.uid;
    _currentUid = uid;
    _ordersSub?.cancel();
    _ordersSub = null;

    if (uid == null) {
      add(OrdersUpdated(null, const []));
      return;
    }

    add(ResetOrdersEvent());
    _ordersSub = _cloud.watchOrders(uid).listen(
      (orders) => add(OrdersUpdated(uid, orders)),
      onError: (_) => add(OrdersUpdated(uid, const [])),
    );
  }

  Future<void> _setStatus(String orderId, OrderStatus status) async {
    final uid = _currentUid;
    if (uid == null) return;
    try {
      await _cloud.updateStatus(uid, orderId, status);
    } catch (_) {
      // The stream keeps showing the status that is actually stored.
    }
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    _ordersSub?.cancel();
    return super.close();
  }
}