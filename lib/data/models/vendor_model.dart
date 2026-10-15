import 'package:flutter_app/domain/entities/vendor.dart';

class VendorModel {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final double latitude;
  final double longitude;
  final String city;

  const VendorModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.latitude,
    required this.longitude,
    required this.city,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      cuisine: (json['cuisine'] ?? '').toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      city: (json['city'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
    };
  }

  Vendor toEntity() {
    return Vendor(
      id: id,
      name: name,
      cuisine: cuisine,
      rating: rating,
      latitude: latitude,
      longitude: longitude,
      city: city,
    );
  }
}
