import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String category;
  final String area;
  final String thumbnail;
  final String instructions;
  final double price;
  final int discountPercent;

  const Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnail,
    required this.instructions,
    required this.price,
    required this.discountPercent,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        area,
        thumbnail,
        instructions,
        price,
        discountPercent,
      ];
}
