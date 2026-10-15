import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/errors/failures.dart';
import 'package:flutter_app/domain/usecases/get_vendors.dart';
import 'package:flutter_app/presentation/blocs/vendor_map/vendor_map_state.dart';

class VendorMapCubit extends Cubit<VendorMapState> {
  final GetVendors getVendors;

  VendorMapCubit({required this.getVendors})
      : super(const VendorMapState());

  Future<void> loadVendors() async {
    emit(state.copyWith(status: VendorMapStatus.loading));
    try {
      final vendors = await getVendors.call();
      emit(state.copyWith(
        status: VendorMapStatus.loaded,
        vendors: vendors,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: VendorMapStatus.error,
        error: UnknownFailure(e.toString()),
      ));
    }
  }
}
