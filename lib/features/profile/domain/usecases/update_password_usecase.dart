import 'package:dartz/dartz.dart';

import 'package:mafuriko/features/profile/domain/repositories/profile_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class UpdatePasswordUseCase extends UseCase<bool, UpdatePassParams> {
  final ProfileRepository _repository;

  UpdatePasswordUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, bool>> call(UpdatePassParams params) async {
    return await _repository.updateUserPassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      passwordConfirmation: params.confirmPassword,
    );
  }
}

class UpdatePassParams {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  UpdatePassParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
