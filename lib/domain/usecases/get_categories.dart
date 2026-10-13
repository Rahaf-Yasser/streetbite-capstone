import 'package:streetbite/domain/entities/category.dart';
import 'package:streetbite/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<({List<Category> categories, Object? error})> call() {
    return repository.getCategories();
  }
}
