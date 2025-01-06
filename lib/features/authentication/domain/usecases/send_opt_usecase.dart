import 'package:firebase_auth/firebase_auth.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';

class SendOtpCodeUseCase {
  final AuthRepository repository;

  SendOtpCodeUseCase(this.repository);

  Future<void> execute(
    String userPhoneNumber, {
    required Function(PhoneAuthCredential credential) completedVerification,
    required Function(FirebaseAuthException e) failedVerification,
    required Function(String verificationId, int? resendToken) onCodeSend,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    return await repository.sendOtpCode(
      userPhoneNumber,
      completedVerification: completedVerification,
      failedVerification: failedVerification,
      onCodeSend: onCodeSend,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
}
