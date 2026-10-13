import 'package:dio/dio.dart';

import 'package:streetbite/core/constants/api_constants.dart';
import 'package:streetbite/core/errors/exceptions.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/models/meal_model.dart';

class MealRemoteDataSourceImpl implements MealDataSource {
  final Dio dio;

  MealRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MealModel>> getMeals() async {
    try {
      final response = await dio.get<dynamic>(
        ApiConstants.mealDbSearchByLetterPath,
        queryParameters: <String, dynamic>{
          'f': ApiConstants.defaultLetter,
        },
      );
      final dynamic data = response.data;
      if (data is! Map<String, dynamic>) {
        throw const ApiException('Unexpected response format');
      }
      final dynamic mealsJson = data['meals'];
      if (mealsJson == null) {
        return const <MealModel>[];
      }
      if (mealsJson is! List) {
        throw const ApiException('Unexpected meals format');
      }
      return mealsJson
          .whereType<Map<String, dynamic>>()
          .map(MealModel.fromJson)
          .toList();
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Network request failed',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Failed to parse meals');
    }
  }
}
