import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class VerifyOtpCode extends UseCase<bool, CheckOTPParams> {
  final AuthRepository repository;

  VerifyOtpCode(this.repository);
  @override
  Future<Either<Failure, bool>> call(CheckOTPParams params) {
    return repository.verifyOtpCode(params.verificationId, params.smsCode);
  }
}

class CheckOTPParams {
  final String verificationId;
  final String smsCode;

  CheckOTPParams({
    required this.verificationId,
    required this.smsCode,
  });
}
