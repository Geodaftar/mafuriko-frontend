import 'package:dartz/dartz.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';

import 'package:mafuriko/features/profile/domain/repositories/profile_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class UpdateUserUseCase extends UseCase<UserEntity, UserFieldsParams> {
  final ProfileRepository _repository;

  UpdateUserUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, UserEntity>> call(UserFieldsParams params) async {
    return await _repository.updateUser(
      userFullName: params.fullName,
      userEmail: params.userEmail,
      userPhoneNumber: params.userPhoneNumber,
    );
  }
}

class UserFieldsParams {
  final String? fullName;
  final String? userEmail;
  final String? userPhoneNumber;

  UserFieldsParams({
    this.fullName,
    this.userEmail,
    this.userPhoneNumber,
  });
}
