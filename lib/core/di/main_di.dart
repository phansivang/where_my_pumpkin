import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';

import '../../features/cat/data/datasources/cat_remote_data_source.dart';
import '../../features/cat/data/repositories/cat_repository_impl.dart';
import '../../features/cat/domain/repositories/cat_repository.dart';
import '../../features/cat/domain/usecases/get_cat_facts_use_case.dart';
import '../../features/cat/presentation/cubit/cat_cubit.dart';
import '../shared/network/api_client.dart';
import '../shared/network/network_info.dart';

part 'cat_di.dart';

/// This is the instance of our Service Locator
final sl = GetIt.instance;

/// This function initialized all service locators
Future<void> init() async {
  //! Internal
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<ApiClient>(
    () => ApiClientImpl(
      client: sl(),
      logger: sl(),
      networkInfo: sl(),
    ),
  );
  //! External
  sl.registerLazySingleton<Client>(() => Client());

  sl.registerLazySingleton(() => InternetConnection());

  sl.registerLazySingleton(() => Logger());

  //! Features
  await initCat();
}
