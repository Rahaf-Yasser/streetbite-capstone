class ApiConstants {
  const ApiConstants._();

  static const String mealDbBaseUrl = 'https://www.themealdb.com';
  static const String mealDbSearchByLetterPath = '/api/json/v1/1/search.php';
  static const String mealDbCategoriesPath = '/api/json/v1/1/categories.php';
  static const String defaultLetter = 'a';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}

class StorageKeys {
  const StorageKeys._();

  static const String cachedMeals = 'streetbite_cached_meals';
  static const String selectedLanguage = 'streetbite_selected_language';
}
