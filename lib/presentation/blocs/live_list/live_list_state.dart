import 'package:equatable/equatable.dart';

enum LiveListStatus { loading, loaded, failure }

/// State shared by every list that streams live from Firestore.
class LiveListState<T> extends Equatable {
  final LiveListStatus status;
  final List<T> items;

  const LiveListState({
    this.status = LiveListStatus.loading,
    this.items = const [],
  });

  @override
  List<Object?> get props => [status, items];
}