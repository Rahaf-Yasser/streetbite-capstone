import 'package:equatable/equatable.dart';
import 'package:flutter_app/core/errors/failures.dart';
import 'package:flutter_app/domain/entities/category.dart';
import 'package:flutter_app/domain/entities/meal.dart';

enum HomeStatus { initial, loading, loaded, error }

enum CategoryStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Meal> meals;
  final Failure? error;
  final bool isRefreshing;
  final CategoryStatus categoryStatus;
  final List<Category> categories;
  final String searchQuery;

  const HomeState({
    this.status = HomeStatus.initial,
    this.meals = const <Meal>[],
    this.error,
    this.isRefreshing = false,
    this.categoryStatus = CategoryStatus.initial,
    this.categories = const <Category>[],
    this.searchQuery = '',
  });

  bool get hasMeals => meals.isNotEmpty;

  bool get isSearching => searchQuery.trim().isNotEmpty;

  /// Meals whose name contains the typed text (case-insensitive).
  List<Meal> get searchResults {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return meals;
    return meals
        .where((meal) => meal.name.toLowerCase().contains(query))
        .toList();
  }

  List<Meal> get bannerMeals {
    if (meals.length <= 5) return meals;
    return meals.sublist(0, 5);
  }

  List<Meal> get hotOffers {
    if (meals.length <= 5) return meals;
    return meals.sublist(0, 5);
  }

  HomeState copyWith({
    HomeStatus? status,
    List<Meal>? meals,
    Failure? error,
    bool? isRefreshing,
    CategoryStatus? categoryStatus,
    List<Category>? categories,
    String? searchQuery,
  }) {
    return HomeState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      error: error ?? this.error,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      categories: categories ?? this.categories,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        meals,
        error,
        isRefreshing,
        categoryStatus,
        categories,
        searchQuery,
      ];
}