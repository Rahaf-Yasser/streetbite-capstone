class MealModel {
  final String id;
  final String name;
  final String category;
  final String area;
  final String thumbnail;
  final String instructions;

  const MealModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnail,
    required this.instructions,
  });

  double get computedPrice {
    final int hash = id.hashCode.abs();
    final int units = (hash % 18) + 5;
    return (units * 1.99).toDouble();
  }

  int get computedDiscountPercent {
    final int hash = id.hashCode.abs();
    return (hash % 25) + 10;
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: (json['idMeal'] ?? '').toString(),
      name: (json['strMeal'] ?? '').toString(),
      category: (json['strCategory'] ?? '').toString(),
      area: (json['strArea'] ?? '').toString(),
      thumbnail: (json['strMealThumb'] ?? '').toString(),
      instructions: (json['strInstructions'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': id,
      'strMeal': name,
      'strCategory': category,
      'strArea': area,
      'strMealThumb': thumbnail,
      'strInstructions': instructions,
    };
  }
}
