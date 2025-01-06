import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/profile/domain/repositories/profile_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class UpdateProfileImageUseCase extends UseCase<UserEntity, XFile?> {
  final ProfileRepository _repository;

  UpdateProfileImageUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, UserEntity>> call(XFile? params) async {
    return await _repository.updateProfileImage(params);
  }
}
