import 'package:streetbite/data/datasources/meal_data_source.dart';

enum DataSourceType { remote, local }

abstract class MealDataSourceFactory {
  MealDataSource create(DataSourceType type);
}
//This factory chooses between the remote API and the local data source
class MealDataSourceFactoryImpl implements MealDataSourceFactory {
  final MealDataSource _remoteDataSource;
  final MealLocalDataSource _localDataSource;

  MealDataSourceFactoryImpl({
    required MealDataSource remoteDataSource,
    required MealLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  MealDataSource create(DataSourceType type) {
    switch (type) {
      case DataSourceType.remote:
        return _remoteDataSource;
      case DataSourceType.local:
        return _localDataSource;
    }
  }
}
