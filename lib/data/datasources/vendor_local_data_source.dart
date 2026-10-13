import 'package:streetbite/data/models/vendor_model.dart';
//These sample vendors are used to show markers in different cities
abstract class VendorDataSource {
  Future<List<VendorModel>> getVendors();
}

class VendorLocalDataSourceImpl implements VendorDataSource {
  const VendorLocalDataSourceImpl();

  static const List<VendorModel> _vendors = <VendorModel>[
    VendorModel(
      id: 'v1',
      name: 'Shawarma Abu Haider',
      cuisine: 'Middle Eastern',
      rating: 4.7,
      latitude: 30.0444,
      longitude: 31.2357,
      city: 'Cairo',
    ),
    VendorModel(
      id: 'v2',
      name: 'المرسى للمأكولات البحرية',
      cuisine: 'Seafood',
      rating: 4.5,
      latitude: 31.2001,
      longitude: 29.9187,
      city: 'Alexandria',
    ),
    VendorModel(
      id: 'v3',
      name: 'Koshary El Tahrir',
      cuisine: 'Egyptian',
      rating: 4.6,
      latitude: 31.0409,
      longitude: 31.3785,
      city: 'Mansoura',
    ),
    VendorModel(
      id: 'v4',
      name: 'El-Kababgy',
      cuisine: 'BBQ',
      rating: 4.4,
      latitude: 25.6872,
      longitude: 32.6396,
      city: 'Luxor',
    ),
    VendorModel(
      id: 'v5',
      name: 'Nubian Kitchen',
      cuisine: 'Nubian',
      rating: 4.8,
      latitude: 24.0889,
      longitude: 32.8998,
      city: 'Aswan',
    ),
  ];

  @override
  Future<List<VendorModel>> getVendors() async {
    return _vendors;
  }
}
