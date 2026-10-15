import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String fullName;
  final String email;
  final String? photoBase64;

  const ProfileEntity({
    required this.fullName,
    required this.email,
    this.photoBase64,
  });

  @override
  List<Object?> get props => [fullName, email, photoBase64];
}