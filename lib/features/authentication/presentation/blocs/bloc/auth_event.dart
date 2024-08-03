part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String userEmail;

  final String userPassword;

  const LoginRequested({
    required this.userEmail,
    required this.userPassword,
  });

  @override
  List<Object> get props => [
        userEmail,
        userPassword,
      ];
}

class SignUpRequested extends AuthEvent {
  final String userEmail;
  final String userName;
  final String userNumber;
  final String userPassword;
  final String confirmPassword;

  const SignUpRequested({
    required this.userEmail,
    required this.userName,
    required this.userNumber,
    required this.userPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [
        userEmail,
        userName,
        userNumber,
        userPassword,
        confirmPassword,
      ];
}

class CheckAuthEvent extends AuthEvent {}

class CheckPhoneNumberEvent extends AuthEvent {
  final String userNumber;
  final Function(PhoneAuthCredential credential) completedVerification;
  final Function(FirebaseAuthException e) failedVerification;
  final Function(String verificationId, int? resendToken) onCodeSend;
  final Function(String verificationId) codeAutoRetrievalTimeout;

  const CheckPhoneNumberEvent({
    required this.userNumber,
    required this.completedVerification,
    required this.failedVerification,
    required this.onCodeSend,
    required this.codeAutoRetrievalTimeout,
  });
}

class VerifyOTPEvent extends AuthEvent {
  final String vId;
  final String otpCode;
  final String phoneNumber;

  const VerifyOTPEvent({
    required this.vId,
    required this.otpCode,
    required this.phoneNumber,
  });
}

class UpdateForgotPasswordEvent extends AuthEvent {
  final String newPass;
  final String newPassConfirm;

  const UpdateForgotPasswordEvent({
    required this.newPass,
    required this.newPassConfirm,
  });
}

class LogOutEvent extends AuthEvent {}
