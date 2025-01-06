part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final UserEntity user;

  const ProfileLoadSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileLoadFailure extends ProfileState {
  final String message;

  const ProfileLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdateSuccess extends ProfileState {
  final UserEntity user;

  const ProfileUpdateSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileUpdateFailure extends ProfileState {
  final String message;

  const ProfileUpdateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdatePassSuccess extends ProfileState {
  const ProfileUpdatePassSuccess();

  @override
  List<Object> get props => [];
}

class ProfileUpdatePassFailure extends ProfileState {
  final String message;

  const ProfileUpdatePassFailure({required this.message});

  @override
  List<Object> get props => [message];
}
