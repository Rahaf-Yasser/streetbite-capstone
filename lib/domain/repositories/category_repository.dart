import 'package:flutter_app/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<({List<Category> categories, Object? error})> getCategories();
}
