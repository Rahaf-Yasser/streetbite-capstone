import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:streetbite/core/network/dio_client.dart';
import 'package:streetbite/data/datasources/category_remote_data_source.dart';
import 'package:streetbite/data/datasources/meal_data_source.dart';
import 'package:streetbite/data/datasources/meal_data_source_factory.dart';
import 'package:streetbite/data/datasources/meal_local_data_source.dart';
import 'package:streetbite/data/datasources/meal_remote_data_source.dart';
import 'package:streetbite/data/datasources/vendor_local_data_source.dart';
import 'package:streetbite/data/repositories/category_repository_impl.dart';
import 'package:streetbite/data/repositories/meal_repository_impl.dart';
import 'package:streetbite/data/repositories/vendor_repository_impl.dart';
import 'package:streetbite/domain/repositories/category_repository.dart';
import 'package:streetbite/domain/repositories/meal_repository.dart';
import 'package:streetbite/domain/repositories/vendor_repository.dart';
import 'package:streetbite/domain/usecases/get_categories.dart';
import 'package:streetbite/domain/usecases/get_meals.dart';
import 'package:streetbite/domain/usecases/get_vendors.dart';
import 'package:streetbite/presentation/blocs/locale/locale_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  final sl = getIt;

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<Dio>(() => DioClient.instance().dio);

  sl.registerLazySingleton<MealDataSource>(
    () => MealRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerLazySingleton<MealLocalDataSource>(
    () => MealLocalDataSourceImpl(sharedPreferences: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<MealDataSourceFactory>(
    () => MealDataSourceFactoryImpl(
      remoteDataSource: sl<MealDataSource>(),
      localDataSource: sl<MealLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<MealRepositoryImpl>(
    () => MealRepositoryImpl(sl<MealDataSourceFactory>()),
  );

  sl.registerLazySingleton<MealRepository>(
    () => sl<MealRepositoryImpl>(),
  );

  sl.registerLazySingleton<GetMeals>(
    () => GetMeals(sl<MealRepository>()),
  );

  sl.registerLazySingleton<GetCachedMeals>(
    () => GetCachedMeals(sl<MealRepository>()),
  );

  sl.registerLazySingleton<VendorDataSource>(
    () => const VendorLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(sl<VendorDataSource>()),
  );

  sl.registerLazySingleton<GetVendors>(
    () => GetVendors(sl<VendorRepository>()),
  );

  sl.registerLazySingleton<CategoryDataSource>(
    () => CategoryRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<CategoryDataSource>()),
  );

  sl.registerLazySingleton<GetCategories>(
    () => GetCategories(sl<CategoryRepository>()),
  );

  sl.registerLazySingleton<LocaleBloc>(
    () => LocaleBloc(sharedPreferences: sl<SharedPreferences>()),
  );
}
