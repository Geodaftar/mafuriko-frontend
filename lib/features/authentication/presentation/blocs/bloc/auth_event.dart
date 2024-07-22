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

class LogOutEvent extends AuthEvent {}
