import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart';

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

  @override
  Future<Either<Failure, bool>> checkNumber(
      {required String userNumber}) async {
    try {
      final response = await dataSource.checkNumber(userNumber: userNumber);

      return Right(response);
    } on ServerException catch (e) {
      log("check number exception error statusCode:::::: ${e.statusCode}");
      log("check number exception error message:::::: ${e.message}");
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> modifyPassWord({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await dataSource.modifyPassword(
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
      );

      return Right(response);
    } on ServerException catch (e) {
      log("modifyPassWord exception error statusCode:::::: ${e.statusCode}");
      log("modifyPassWord exception error message:::::: ${e.message}");
      return Left(ServerFailure(message: e.message));
    }
  }

// firebase auth otp
  @override
  Future<void> sendOtpCode(
    String userPhoneNumber, {
    required Function(PhoneAuthCredential credential) completedVerification,
    required Function(FirebaseAuthException e) failedVerification,
    required Function(String verificationId, int? resendToken) onCodeSend,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    try {
      await dataSource.sendOtpCode(userPhoneNumber,
          completedVerification: completedVerification,
          failedVerification: failedVerification,
          onCodeSend: onCodeSend,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } on ServerException catch (e) {
      log("send otp code to number exception error statusCode:::::: ${e.statusCode}");
      log("send otp code to number exception error message:::::: ${e.message}");
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtpCode(
      String verificationId, String smsCode) async {
    try {
      final response = await dataSource.verifyOtpCode(verificationId, smsCode);

      return Right(response);
    } on ServerException catch (e) {
      log("verify otp code exception error statusCode:::::: ${e.statusCode}");
      log("verify otp code exception error message:::::: ${e.message}");
      return Left(ServerFailure(message: e.message));
    }
  }
}
