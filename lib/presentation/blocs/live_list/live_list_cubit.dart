import 'dart:async';

import 'package:flutter_app/presentation/blocs/live_list/live_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Generic Cubit: listens to a Firestore stream and turns it into
/// loading / loaded / failure states. Favourites and Order History
/// both extend it, so this logic is written only once.
abstract class LiveListCubit<T> extends Cubit<LiveListState<T>> {
  final Stream<List<T>> Function() _source;
  StreamSubscription<List<T>>? _subscription;

  LiveListCubit(this._source) : super(const LiveListState());

  Future<void> load() async {
    emit(const LiveListState());
    await _subscription?.cancel();
    _subscription = _source().listen(
      (items) {
        if (isClosed) return;
        emit(LiveListState(status: LiveListStatus.loaded, items: items));
      },
      onError: (_) {
        if (isClosed) return;
        emit(const LiveListState(status: LiveListStatus.failure));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}