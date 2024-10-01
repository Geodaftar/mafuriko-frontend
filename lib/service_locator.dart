import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_password_usecase.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/core/common/data_local/auth_local_data_source.dart';
import 'package:mafuriko/features/authentication/domain/usecases/check_number_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/get_cache.dart';
import 'package:mafuriko/features/authentication/domain/usecases/login_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/modify_pass_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/send_opt_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mafuriko/features/maps/data/repositories/location_repository_impl.dart';
import 'package:mafuriko/features/maps/data/services/geolocator_service.dart';
import 'package:mafuriko/features/maps/domain/usecases/get_user_location_usecase.dart';
import 'package:mafuriko/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:mafuriko/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mafuriko/features/profile/domain/repositories/profile_repository.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mafuriko/features/send/data/datasources/remote/alert_remote_data_source.dart';
import 'package:mafuriko/features/send/data/repositories/alert_repository_impl.dart';
import 'package:mafuriko/features/send/domain/repositories/alert_repository.dart';
import 'package:mafuriko/features/send/domain/usecases/fetch_alert_usecase.dart';
import 'package:mafuriko/features/send/domain/usecases/post_alert_usecase.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/shared/helpers/network_info.dart';

import 'features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/signup_usecase.dart';
import 'features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'features/maps/domain/repositories/location_repository.dart';
import 'features/maps/presentation/bloc/map_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  final FirebaseAuth authInit = FirebaseAuth.instance;
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Geolocator());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => authInit);

  // Data sources
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl(), auth: sl()),
  );
  sl.registerFactory<HttpClient>(
    () => HttpClient(sl(), sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<GeolocatorService>(
    () => GeolocatorService(),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AlertRemoteDataSource>(
    () => AlertRemoteDataSourceImpl(sl()),
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
  sl.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerFactory<LocationRepository>(
    () => LocationRepositoryImpl(
      sl(),
    ),
  );
  sl.registerFactory<AlertRepository>(
    () => AlertRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedUser(sl()));
  sl.registerLazySingleton(() => SendOtpCodeUseCase(sl()));
  sl.registerLazySingleton(() => CheckNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpCode(sl()));
  sl.registerLazySingleton(() => ModifyPassUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetUserLocationUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => FetchAlertUseCase(sl()));
  sl.registerLazySingleton(() => PostAlertUseCase(sl()));

  // BloC
  sl.registerLazySingleton(
    () => AuthBloc(
      signUpUseCase: sl(),
      loginUseCase: sl(),
      getCachedUser: sl(),
      checkNumberUseCase: sl(),
      sendOtpCodeUseCase: sl(),
      verifyOtpCode: sl(),
      modifyPassUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => MapBloc(sl()),
  );
  sl.registerLazySingleton(
    () => ProfileBloc(sl(), sl(), sl()),
  );
  sl.registerLazySingleton(
    () => AlertBloc(sl(), sl()),
  );
}
