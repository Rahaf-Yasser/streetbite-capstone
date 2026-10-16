import 'package:equatable/equatable.dart';

/// A user as the rest of the app sees them (no Firebase, no JSON).
class UserEntity extends Equatable {
  final String? uid;
  final String fullName;
  final String email;
  final String? photoUrl;

  const UserEntity({
    this.uid,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, fullName, email, photoUrl];
}