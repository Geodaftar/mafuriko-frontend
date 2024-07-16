import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

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
      return Right(data!);
    } on ServerException catch (e) {
      log(e.message);
      return Left(ServerFailure(message: e.message));
    }
  }
}
