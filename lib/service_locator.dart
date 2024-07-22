import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/shared/helpers/network_info.dart';
import 'package:mafuriko/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:mafuriko/features/authentication/domain/usecases/get_cache.dart';
import 'package:mafuriko/features/authentication/domain/usecases/login_usecase.dart';
import 'package:nb_utils/nb_utils.dart';

import 'features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/signup_usecase.dart';
import 'features/authentication/presentation/blocs/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerFactory<HttpClient>(
    () => HttpClient(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Core Network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // Repositories
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUser(sl()));

  // BloC
  sl.registerLazySingleton(
    () => AuthBloc(
      signUpUseCase: sl(),
      loginUseCase: sl(),
      getCachedUser: sl(),
    ),
  );
}
