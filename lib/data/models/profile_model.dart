import 'package:flutter_app/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.fullName,
    required super.email,
    super.photoBase64,
  });

  /// FACTORY CONSTRUCTOR: builds a model from a Firestore document map.
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoBase64: json['photoBase64'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'photoBase64': photoBase64,
      };
}