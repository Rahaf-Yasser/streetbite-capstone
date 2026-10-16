import 'package:flutter_app/data/models/user_builder.dart';
import 'package:flutter_app/domain/entities/user_entity.dart';

/// Data-layer user. Extends the domain [UserEntity] and adds JSON conversion.
class UserModel extends UserEntity {
  /// Used by [UserBuilder.build]: only the sign-up fields (full name and
  /// email) are set on construction.
  UserModel.fromBuilder(UserBuilder builder)
      : super(fullName: builder.fullName!, email: builder.email!);

  const UserModel._full({
    super.uid,
    required super.fullName,
    required super.email,
    super.photoUrl,
  });

  /// FACTORY CONSTRUCTOR: builds a user from a Firestore document map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel._full(
      uid: json['uid'] as String?,
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoUrl: json['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'photoUrl': photoUrl,
      };

  /// Fills in the fields Firebase provides after the account exists.
  UserModel copyWith({String? uid, String? photoUrl}) {
    return UserModel._full(
      uid: uid ?? this.uid,
      fullName: fullName,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}