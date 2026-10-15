import 'package:flutter_app/domain/entities/vendor.dart';

abstract class VendorRepository {
  Future<List<Vendor>> getVendors();
}
