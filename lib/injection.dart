import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/core/services/firestore_service.dart';
import 'package:flutter_app/core/network/dio_client.dart';
import 'package:flutter_app/data/datasources/biometric_datasource.dart';
import 'package:flutter_app/data/datasources/device_info_datasource.dart';
import 'package:flutter_app/data/datasources/profile_datasource.dart';
import 'package:flutter_app/data/datasources/image_picker_datasource.dart';
import 'package:flutter_app/data/datasources/user_collections_datasource.dart';
import 'package:flutter_app/data/datasources/category_remote_data_source.dart';
import 'package:flutter_app/data/datasources/meal_data_source.dart';
import 'package:flutter_app/data/datasources/meal_data_source_factory.dart';
import 'package:flutter_app/data/datasources/meal_local_data_source.dart';
import 'package:flutter_app/data/datasources/meal_remote_data_source.dart';
import 'package:flutter_app/data/datasources/vendor_local_data_source.dart';
import 'package:flutter_app/data/repositories/biometric_repository_impl.dart';
import 'package:flutter_app/data/repositories/device_info_repository_impl.dart';
import 'package:flutter_app/data/repositories/profile_repository_impl.dart';
import 'package:flutter_app/data/repositories/photo_picker_repository_impl.dart';
import 'package:flutter_app/data/repositories/favourites_repository_impl.dart';
import 'package:flutter_app/data/repositories/orders_repository_impl.dart';
import 'package:flutter_app/data/repositories/category_repository_impl.dart';
import 'package:flutter_app/data/repositories/meal_repository_impl.dart';
import 'package:flutter_app/data/repositories/vendor_repository_impl.dart';
import 'package:flutter_app/domain/repositories/auth_repository.dart';
import 'package:flutter_app/domain/repositories/biometric_repository.dart';
import 'package:flutter_app/domain/repositories/device_info_repository.dart';
import 'package:flutter_app/domain/repositories/profile_repository.dart';
import 'package:flutter_app/domain/repositories/photo_picker_repository.dart';
import 'package:flutter_app/domain/repositories/favourites_repository.dart';
import 'package:flutter_app/domain/repositories/orders_repository.dart';
import 'package:flutter_app/domain/repositories/category_repository.dart';
import 'package:flutter_app/domain/repositories/meal_repository.dart';
import 'package:flutter_app/domain/repositories/vendor_repository.dart';
import 'package:flutter_app/domain/usecases/authenticate_with_biometrics_usecase.dart';
import 'package:flutter_app/domain/usecases/get_device_details_usecase.dart';
import 'package:flutter_app/domain/usecases/watch_profile_usecase.dart';
import 'package:flutter_app/core/services/locale_preferences_service.dart';
import 'package:flutter_app/domain/usecases/pick_profile_photo_usecase.dart';
import 'package:flutter_app/domain/usecases/update_profile_photo_usecase.dart';
import 'package:flutter_app/domain/usecases/watch_favourites_usecase.dart';
import 'package:flutter_app/domain/usecases/watch_orders_usecase.dart';
import 'package:flutter_app/domain/usecases/get_categories.dart';
import 'package:flutter_app/domain/usecases/get_meals.dart';
import 'package:flutter_app/domain/usecases/get_vendors.dart';
import 'package:flutter_app/presentation/blocs/auth/auth_cubit.dart';
import 'package:flutter_app/presentation/blocs/biometric/biometric_cubit.dart';
import 'package:flutter_app/presentation/blocs/locale/locale_cubit.dart';
import 'package:flutter_app/presentation/blocs/profile/profile_cubit.dart';
import 'package:flutter_app/presentation/blocs/favourites/favourites_cubit.dart';
import 'package:flutter_app/presentation/blocs/order_history/order_history_cubit.dart';
import 'package:flutter_app/data/datasources/orders_cloud_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_app/domain/usecases/log_in_usecase.dart';
import 'package:flutter_app/domain/usecases/log_out_usecase.dart';
import 'package:flutter_app/domain/usecases/sign_up_usecase.dart';
import 'package:flutter_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_app/data/repositories/auth_repository_impl.dart';



/// SINGLETON PATTERN.
/// Where: the dependency container itself, and every `registerLazySingleton`
/// below (FirestoreService, Dio, SharedPreferences, the repositories).
/// Why: `GetIt.instance` always returns the same container, and each
/// singleton is created once and reused, so the whole app shares one
/// Firestore connection and one copy of each service.


final GetIt getIt = GetIt.instance;



Future<void> setupDependencies() async {
  // Initialize local storage
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // --------------------------------------------------
  // Networking
  // --------------------------------------------------

  getIt.registerLazySingleton<Dio>(
    () => DioClient.instance().dio,
  );

  // --------------------------------------------------
  // Firebase and authentication
  // --------------------------------------------------

    getIt.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  getIt.registerLazySingleton<FirestoreService>(
    () => FirestoreService(),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      getIt<FirebaseAuth>(),
      getIt<FirestoreService>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );


  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogInUseCase>(
    () => LogInUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<LogOutUseCase>(
    () => LogOutUseCase(getIt<AuthRepository>()),
  );

  // FACTORY PATTERN (Cubits).
  // Where: every `registerFactory` in this file (AuthCubit, BiometricCubit,
  // ProfileCubit, FavouritesCubit, OrderHistoryCubit).
  // Why: a factory builds a NEW Cubit each time one is requested, so every
  // BlocProvider gets its own instance with its own state, and the provider
  // closes it when it leaves the widget tree.


  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      getCurrentUser: getIt<GetCurrentUserUseCase>(),
      signUp: getIt<SignUpUseCase>(),
      logIn: getIt<LogInUseCase>(),
      logOut: getIt<LogOutUseCase>(),
    ),
  );

  // --------------------------------------------------
  // Localization
  // -----------------------------------------------

  getIt.registerLazySingleton<LocalePreferencesService>(
    () => LocalePreferencesService(),
  );
  getIt.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(getIt<LocalePreferencesService>()),
  );
  // --------------------------------------------------
  // Biometrics
  // --------------------------------------------------

  getIt.registerLazySingleton<LocalAuthentication>(
    () => LocalAuthentication(),
  );

  getIt.registerLazySingleton<BiometricDataSource>(
    () => BiometricDataSource(getIt<LocalAuthentication>()),
  );

  getIt.registerLazySingleton<BiometricRepository>(
    () => BiometricRepositoryImpl(getIt<BiometricDataSource>()),
  );

  getIt.registerLazySingleton<AuthenticateWithBiometricsUseCase>(
    () => AuthenticateWithBiometricsUseCase(
      getIt<BiometricRepository>(),
    ),
  );

  getIt.registerFactory<BiometricCubit>(
    () => BiometricCubit(
      getIt<AuthenticateWithBiometricsUseCase>(),
    ),
  );

  // --------------------------------------------------
  // Profile and device information
  // --------------------------------------------------

  getIt.registerLazySingleton<DeviceInfoPlugin>(
    () => DeviceInfoPlugin(),
  );

  getIt.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSource(
      getIt<FirebaseAuth>(),
      getIt<FirestoreService>(),
    ),
  );

  getIt.registerLazySingleton<DeviceInfoDataSource>(
    () => DeviceInfoDataSource(getIt<DeviceInfoPlugin>()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileDataSource>()),
  );

  getIt.registerLazySingleton<DeviceInfoRepository>(
    () => DeviceInfoRepositoryImpl(
      getIt<DeviceInfoDataSource>(),
    ),
  );

  getIt.registerLazySingleton<WatchProfileUseCase>(
    () => WatchProfileUseCase(getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<GetDeviceDetailsUseCase>(
    () => GetDeviceDetailsUseCase(
      getIt<DeviceInfoRepository>(),
    ),
  );

  // --------------------------------------------------
  // Profile photo
  // --------------------------------------------------

  getIt.registerLazySingleton<ImagePicker>(
    () => ImagePicker(),
  );

  getIt.registerLazySingleton<ImagePickerDataSource>(
    () => ImagePickerDataSource(getIt<ImagePicker>()),
  );

  getIt.registerLazySingleton<PhotoPickerRepository>(
    () => PhotoPickerRepositoryImpl(
      getIt<ImagePickerDataSource>(),
    ),
  );

  getIt.registerLazySingleton<PickProfilePhotoUseCase>(
    () => PickProfilePhotoUseCase(
      getIt<PhotoPickerRepository>(),
    ),
  );

  getIt.registerLazySingleton<UpdateProfilePhotoUseCase>(
    () => UpdateProfilePhotoUseCase(
      getIt<ProfileRepository>(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getIt<WatchProfileUseCase>(),
      getIt<GetDeviceDetailsUseCase>(),
      getIt<PickProfilePhotoUseCase>(),
      getIt<UpdateProfilePhotoUseCase>(),
    ),
  );

  // --------------------------------------------------
  // Favourites and order history
  // --------------------------------------------------

  getIt.registerLazySingleton<UserCollectionsDataSource>(
    () => UserCollectionsDataSource(
      getIt<FirebaseAuth>(),
      getIt<FirestoreService>(),
    ),
  );

  getIt.registerLazySingleton<FavouritesRepository>(
    () => FavouritesRepositoryImpl(
      getIt<UserCollectionsDataSource>(),
    ),
  );

  getIt.registerLazySingleton<OrderRepository>(
  () => OrderRepositoryImpl(
    getIt<UserCollectionsDataSource>(),
    firestoreService: getIt<FirestoreService>(),
  ),
);

  getIt.registerLazySingleton<WatchFavouritesUseCase>(
    () => WatchFavouritesUseCase(
      getIt<FavouritesRepository>(),
    ),
  );

  getIt.registerLazySingleton<WatchOrdersUseCase>(
    () => WatchOrdersUseCase(
      getIt<OrderRepository>(),
    ),
  );

  getIt.registerFactory<FavouritesCubit>(
    () => FavouritesCubit(
      getIt<WatchFavouritesUseCase>(),
    ),
  );

  getIt.registerFactory<OrderHistoryCubit>(
  () => OrderHistoryCubit(
    getIt<WatchOrdersUseCase>(),
    userId: getIt<FirebaseAuth>().currentUser?.uid ?? '', 
  ),
);

  // --------------------------------------------------
  // Meals: remote and local data sources
  // --------------------------------------------------

  getIt.registerLazySingleton<MealDataSource>(
    () => MealRemoteDataSourceImpl(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<MealLocalDataSource>(
    () => MealLocalDataSourceImpl(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerLazySingleton<MealDataSourceFactory>(
    () => MealDataSourceFactoryImpl(
      remoteDataSource: getIt<MealDataSource>(),
      localDataSource: getIt<MealLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<MealRepositoryImpl>(
  () => MealRepositoryImpl(
    getIt<MealDataSourceFactory>(),
    firestoreService: getIt<FirestoreService>(), 
  ),
);

  getIt.registerLazySingleton<MealRepository>(
    () => getIt<MealRepositoryImpl>(),
  );

  getIt.registerLazySingleton<GetMeals>(
    () => GetMeals(getIt<MealRepository>()),
  );

  getIt.registerLazySingleton<GetCachedMeals>(
    () => GetCachedMeals(getIt<MealRepository>()),
  );
  

  // --------------------------------------------------
  // Vendors
  // --------------------------------------------------

  getIt.registerLazySingleton<VendorDataSource>(
    () => const VendorLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(
      getIt<VendorDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetVendors>(
    () => GetVendors(getIt<VendorRepository>()),
  );

  // --------------------------------------------------
  // Categories
  // --------------------------------------------------

  getIt.registerLazySingleton<CategoryDataSource>(
    () => CategoryRemoteDataSourceImpl(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      getIt<CategoryDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetCategories>(
    () => GetCategories(getIt<CategoryRepository>()),
  );

  // Orders (cloud)
  getIt.registerLazySingleton<OrdersCloudDataSource>(
  () => OrdersCloudDataSource(getIt<FirestoreService>()),
  );
}