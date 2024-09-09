import 'package:dartz/dartz.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/shared/errors/failures.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserEntity>> updateUser({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
  });
  Future<Either<Failure, bool>> updateUserPassword({
    required String currentPassword,
    required String newPassword,
    required String passwordConfirmation,
  });
}
