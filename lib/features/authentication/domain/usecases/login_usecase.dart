import 'package:dartz/dartz.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class LoginUseCase extends UseCase<UserEntity, LogInParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LogInParams params) async {
    return await repository.login(
      userEmail: params.email,
      userPassword: params.password,
    );
  }
}

class LogInParams {
  final String email;
  final String password;

  LogInParams({
    required this.email,
    required this.password,
  });
}
