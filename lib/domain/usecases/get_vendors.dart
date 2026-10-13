import 'package:streetbite/domain/entities/vendor.dart';
import 'package:streetbite/domain/repositories/vendor_repository.dart';

class GetVendors {
  final VendorRepository repository;

  GetVendors(this.repository);

  Future<List<Vendor>> call() {
    return repository.getVendors();
  }
}
