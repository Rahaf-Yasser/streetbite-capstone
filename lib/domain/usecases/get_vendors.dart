import 'package:flutter_app/domain/entities/vendor.dart';
import 'package:flutter_app/domain/repositories/vendor_repository.dart';

class GetVendors {
  final VendorRepository repository;

  GetVendors(this.repository);

  Future<List<Vendor>> call() {
    return repository.getVendors();
  }
}
