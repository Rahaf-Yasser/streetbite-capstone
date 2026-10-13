import 'package:equatable/equatable.dart';
import 'package:streetbite/core/errors/failures.dart';
import 'package:streetbite/domain/entities/vendor.dart';

enum VendorMapStatus { initial, loading, loaded, error }

class VendorMapState extends Equatable {
  final VendorMapStatus status;
  final List<Vendor> vendors;
  final Failure? error;

  const VendorMapState({
    this.status = VendorMapStatus.initial,
    this.vendors = const <Vendor>[],
    this.error,
  });

  VendorMapState copyWith({
    VendorMapStatus? status,
    List<Vendor>? vendors,
    Failure? error,
  }) {
    return VendorMapState(
      status: status ?? this.status,
      vendors: vendors ?? this.vendors,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, vendors, error];
}
