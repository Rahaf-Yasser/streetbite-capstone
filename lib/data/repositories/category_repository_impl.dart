import 'package:flutter_app/data/datasources/category_remote_data_source.dart';
import 'package:flutter_app/domain/entities/category.dart';
import 'package:flutter_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<({List<Category> categories, Object? error})> getCategories() async {
    try {
      final models = await _dataSource.getCategories();
      return (
        categories: models.map((m) => m.toEntity()).toList(),
        error: null,
      );
    } catch (e) {
      return (categories: const <Category>[], error: e);
    }
  }
}
