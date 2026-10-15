import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? uid;
  final String fullName;
  final String email;
  final String? photoUrl;

  const UserModel._({
    this.uid,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  UserModel copyWith({String? uid, String? photoUrl}) {
    return UserModel._(
      uid: uid ?? this.uid,
      fullName: fullName,
      email: email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'fullName': fullName,
        'email': email,
        'photoUrl': photoUrl,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel._(
      uid: map['uid'] as String?,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [uid, fullName, email, photoUrl];
}

class UserBuilder {
  String? _fullName;
  String? _email;

  UserBuilder setFullName(String fullName) {
    _fullName = fullName;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserModel build() {
    if (_fullName == null || _email == null) {
      throw StateError('fullName and email are required');
    }
    return UserModel._(fullName: _fullName!, email: _email!);
  }
}