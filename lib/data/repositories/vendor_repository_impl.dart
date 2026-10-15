import 'package:flutter_app/data/datasources/vendor_local_data_source.dart';
import 'package:flutter_app/domain/entities/vendor.dart';
import 'package:flutter_app/domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorDataSource _dataSource;

  VendorRepositoryImpl(this._dataSource);

  @override
  Future<List<Vendor>> getVendors() async {
    final models = await _dataSource.getVendors();
    return models.map((m) => m.toEntity()).toList();
  }
}
