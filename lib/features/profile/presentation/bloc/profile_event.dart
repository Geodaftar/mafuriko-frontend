part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends ProfileEvent {
  final UserEntity user;

  const LoadUserProfile(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateProfileEvent extends ProfileEvent {
  final String userName;
  final String userEmail;
  final String phoneNumber;

  const UpdateProfileEvent({
    required this.userName,
    required this.userEmail,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [userName, userEmail, phoneNumber];
}

class ModifyPasswordEvent extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ModifyPasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];
}
