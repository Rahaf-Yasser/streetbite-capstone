import 'package:equatable/equatable.dart';

class Vendor extends Equatable {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final double latitude;
  final double longitude;
  final String city;

  const Vendor({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        cuisine,
        rating,
        latitude,
        longitude,
        city,
      ];
}
