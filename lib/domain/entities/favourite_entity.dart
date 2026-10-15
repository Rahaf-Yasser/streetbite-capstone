import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable {
  final String id;
  final String name;
  final String? subtitle;

  const FavouriteEntity({
    required this.id,
    required this.name,
    this.subtitle,
  });

  @override
  List<Object?> get props => [id, name, subtitle];
}