part of 'auth_bloc.dart';

enum Request {
  unknown,
  login,
  signup,
  updatePassword,
  updateUser,
  verifyOtpCode,
  checkUser,
}

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final Request request;

  const AuthSuccess({required this.user, this.request = Request.unknown});

  @override
  List<Object> get props => [user, request];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthCheckNumSuccess extends AuthState {
  final bool val;

  const AuthCheckNumSuccess({required this.val});

  @override
  List<Object> get props => [val];
}

class SuccessOTP extends AuthState {
  final bool val;
  final String userNumber;

  const SuccessOTP({required this.val, required this.userNumber});

  @override
  List<Object> get props => [val, userNumber];
}

class AuthUnauthenticated extends AuthState {}
