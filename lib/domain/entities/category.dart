import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, thumbnail, description];
}
