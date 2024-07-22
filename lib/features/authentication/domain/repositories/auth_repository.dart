import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';

import 'package:mafuriko/shared/errors/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp({
    required String userEmail,
    required String userName,
    required String userNumber,
    required String userPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, UserEntity>> login({
    required String userEmail,
    required String userPassword,
  });

  Future<Either<Failure, UserEntity>> isLoggedIn();

  Future<void> logout();
}
