import 'package:streetbite/domain/entities/category.dart';

class CategoryModel {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: (json['idCategory'] ?? '').toString(),
      name: (json['strCategory'] ?? '').toString(),
      thumbnail: (json['strCategoryThumb'] ?? '').toString(),
      description: (json['strCategoryDescription'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': id,
      'strCategory': name,
      'strCategoryThumb': thumbnail,
      'strCategoryDescription': description,
    };
  }

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      thumbnail: thumbnail,
      description: description,
    );
  }
}
