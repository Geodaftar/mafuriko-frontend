import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';

import 'package:mafuriko/shared/errors/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp({
    required String userEmail,
    required String userName,
    required String userNumber,
    required String userPassword,
    required String confirmPassword,
  });

  Future<Either<Failure, UserEntity>> login({
    required String userEmail,
    required String userPassword,
  });

  Future<Either<Failure, UserEntity>> isLoggedIn();

  Future<void> logout();

  Future<Either<Failure, bool>> checkNumber({required String userNumber});

  Future<Either<Failure, UserEntity>> modifyPassWord({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });

  Future<void> sendOtpCode(
    String userPhoneNumber, {
    required Function(PhoneAuthCredential credential) completedVerification,
    required Function(FirebaseAuthException e) failedVerification,
    required Function(String verificationId, int? resendToken) onCodeSend,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  });

  Future<Either<Failure, bool>> verifyOtpCode(
      String verificationId, String smsCode);
}
