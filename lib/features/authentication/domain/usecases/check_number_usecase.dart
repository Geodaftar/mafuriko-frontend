import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class CheckNumberUseCase extends UseCase<bool, String> {
  final AuthRepository repository;

  CheckNumberUseCase(this.repository);
  @override
  Future<Either<Failure, bool>> call(String params) {
    return repository.checkNumber(userNumber: params);
  }
}
