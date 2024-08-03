part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
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
