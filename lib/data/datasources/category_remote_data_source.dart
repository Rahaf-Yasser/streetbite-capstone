import 'package:dio/dio.dart';

import 'package:streetbite/core/constants/api_constants.dart';
import 'package:streetbite/core/errors/exceptions.dart';
import 'package:streetbite/data/models/category_model.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get<dynamic>(
        ApiConstants.mealDbCategoriesPath,
      );
      final dynamic data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const ApiException('Unexpected response format');
      }
      final dynamic categoriesJson = data['categories'];
      if (categoriesJson == null) {
        return const <CategoryModel>[];
      }
      if (categoriesJson is! List) {
        throw const ApiException('Unexpected categories format');
      }
      return categoriesJson
          .whereType<Map<String, dynamic>>()
          .map(CategoryModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Network request failed',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to parse categories');
    }
  }
}
