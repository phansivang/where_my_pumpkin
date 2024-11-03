part of 'main_di.dart';

/// This function initialized all cat service locators
Future<void> initCat() async {
  //* Cubit
  sl.registerFactory<CatCubit>(() => CatCubit(getCatFactsUseCase: sl()));

  //* Use cases
  sl.registerLazySingleton<GetCatFactsUseCase>(
    () => GetCatFactsUseCase(sl()),
  );
  //* Repository
  sl.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  //* Data sources
  sl.registerLazySingleton<CatRemoteDataSource>(
    () => CatRemoteDataSourceImpl(
      apiClient: sl(),
    ),
  );
}
