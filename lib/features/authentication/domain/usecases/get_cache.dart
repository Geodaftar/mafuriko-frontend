import 'package:dartz/dartz.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class GetCachedUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GetCachedUser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(_) async {
    return await repository.isLoggedIn();
  }
}
