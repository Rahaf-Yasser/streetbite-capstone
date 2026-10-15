import 'package:flutter_app/domain/entities/order_entity.dart';
import 'package:flutter_app/domain/usecases/watch_orders_usecase.dart';
import 'package:flutter_app/presentation/blocs/live_list/live_list_cubit.dart';

class OrderHistoryCubit extends LiveListCubit<OrderEntity> {
  final WatchOrdersUseCase _useCase;
  final String userId;

  OrderHistoryCubit(this._useCase, {required this.userId})
      : super(() => _useCase(userId));
}