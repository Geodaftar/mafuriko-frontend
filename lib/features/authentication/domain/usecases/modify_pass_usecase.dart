import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class ModifyPassUseCase extends UseCase<UserEntity, ModifyPassParams> {
  final AuthRepository repository;

  ModifyPassUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(ModifyPassParams params) async {
    return await repository.modifyPassWord(
      phoneNumber: params.phoneNumber,
      password: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class ModifyPassParams {
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  ModifyPassParams({
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
