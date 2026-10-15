import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/core/constants/api_constants.dart';
import 'package:flutter_app/core/errors/exceptions.dart';
import 'package:flutter_app/data/datasources/meal_data_source.dart';
import 'package:flutter_app/data/models/meal_model.dart';

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final SharedPreferences sharedPreferences;

  MealLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MealModel>> getMeals() async {
    try {
      final String? raw = sharedPreferences.getString(StorageKeys.cachedMeals);
      if (raw == null || raw.isEmpty) {
        return const <MealModel>[];
      }
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(MealModel.fromJson)
          .toList();
    } catch (e) {
      throw const CacheException('Failed to read cached meals');
    }
  }

  @override
  Future<void> cacheMeals(List<MealModel> meals) async {
    try {
      final List<Map<String, dynamic>> encoded =
          meals.map((MealModel m) => m.toJson()).toList();
      await sharedPreferences.setString(
        StorageKeys.cachedMeals,
        jsonEncode(encoded),
      );
    } catch (e) {
      throw const CacheException('Failed to cache meals');
    }
  }
}
