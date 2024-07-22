import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:mafuriko/shared/helpers/network_info.dart';
import 'package:mafuriko/features/authentication/data/datasources/local/auth_local_data_source.dart';
import 'package:mafuriko/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.dataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String userEmail,
    required String userName,
    required String userNumber,
    required String userPassword,
    required String confirmPassword,
  }) async {
    try {
      final data = await dataSource.signUp(
        userEmail: userEmail,
        userName: userName,
        userNumber: userNumber,
        userPassword: userPassword,
        confirmPassword: confirmPassword,
      );

      localDataSource.cacheUser(data);
      return Right(data);
    } on ServerException catch (e) {
      log(e.message);
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
      {required String userEmail, required String userPassword}) async {
    try {
      final data = await dataSource.login(
          userEmail: userEmail, userPassword: userPassword);

      log('from auth repo impl :: login request ::: data **** ${data.toJson()}');

      localDataSource.cacheUser(data);

      return Right(data);
    } on ServerException catch (e) {
      log('::::::::::${e.message}');
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> isLoggedIn() async {
    try {
      final localUser = await localDataSource.getCachedUser();
      if (localUser != null) {
        log('message from auth repo impl ::::: localUser ==== ${localUser.toJson()}');
        return Right(localUser);
      } else {
        return const Left(CacheFailure(
            message: 'Une Erreur est survenue lors de la mise en cache.'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearCachedUser();
  }
}
