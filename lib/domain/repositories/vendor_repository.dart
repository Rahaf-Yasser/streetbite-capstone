import 'package:streetbite/domain/entities/vendor.dart';

abstract class VendorRepository {
  Future<List<Vendor>> getVendors();
}
