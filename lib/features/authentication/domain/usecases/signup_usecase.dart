import 'package:dartz/dartz.dart';

import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class SignUpUseCase extends UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUp(
      userEmail: params.email,
      userNumber: params.phoneNumber,
      userPassword: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class SignUpParams {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  SignUpParams({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
