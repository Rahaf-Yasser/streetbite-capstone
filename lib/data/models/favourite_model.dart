import 'package:flutter_app/domain/entities/favourite_entity.dart';

class FavouriteModel extends FavouriteEntity {
  const FavouriteModel({
    required super.id,
    required super.name,
    super.subtitle,
  });

  /// FACTORY CONSTRUCTOR: builds a model from a Firestore document map.
  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      subtitle: json['subtitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'subtitle': subtitle,
      };
}