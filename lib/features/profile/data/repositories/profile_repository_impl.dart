import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/core/common/data_local/auth_local_data_source.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:mafuriko/features/profile/domain/repositories/profile_repository.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AuthLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required ProfileRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, bool>> updateUserPassword(
      {required String currentPassword,
      required String newPassword,
      required String passwordConfirmation}) async {
    try {
      final data = await _remoteDataSource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: passwordConfirmation,
      );
      return Right(data);
    } on ServerException catch (e) {
      log('updatePassword exception error message::::::::: ${e.message}');
      log('updatePassword exception error statusCode::::::::: ${e.statusCode}');
      log('updatePassword exception error code::::::::: ${e.code}');
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
      {String? userFullName,
      String? userEmail,
      String? userPhoneNumber}) async {
    try {
      final data = await _remoteDataSource.updateUser(
        fullName: userFullName,
        userEmail: userEmail,
        userPhoneNumber: userPhoneNumber,
      );
      // _localDataSource.clearCachedUser();
      _localDataSource.cacheUser(data);

      return Right(data);
    } on ServerException catch (e) {
      log('updatePassword exception error message::::::::: ${e.message}');
      log('updatePassword exception error statusCode::::::::: ${e.statusCode}');
      log('updatePassword exception error code::::::::: ${e.code}');
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfileImage(XFile? image) async {
    try {
      log('updateProfileImage exception error img path::::::::: ${image?.path ?? "empty"}');
      final data = await _remoteDataSource.updateProfileImage(image);
      _localDataSource.cacheUser(data);

      return Right(data);
    } on ServerException catch (e) {
      log('updateProfileImage exception error message::::::::: ${e.message}');
      log('updateProfileImage exception error statusCode::::::::: ${e.statusCode}');
      log('updateProfileImage exception error code::::::::: ${e.code}');
      return Left(ServerFailure(message: e.message));
    }
  }
}
