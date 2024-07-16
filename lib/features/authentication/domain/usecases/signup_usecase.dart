import 'package:dartz/dartz.dart';

import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class SignUpUseCase extends UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) async {
    return await repository.signUp(
      userEmail: params.email,
      userName: params.fullName,
      userNumber: params.phoneNumber,
      userPassword: params.password,
      confirmPassword: params.confirmPassword,
    );
  }
}

class SignInParams {
  final String email;
  final String fullName;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  SignInParams({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
