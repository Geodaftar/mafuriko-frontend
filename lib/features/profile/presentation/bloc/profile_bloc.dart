import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_password_usecase.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:mafuriko/shared/helpers/image_pick_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUseCase _updateProfileUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;
  final AuthBloc _authBloc;
  late StreamSubscription _authBlocSubscription;
  final FilesPicker picker = FilesPicker();

  ProfileBloc(
    this._updatePasswordUseCase,
    this._updateProfileUseCase,
    this._authBloc,
    this._updateProfileImageUseCase,
  ) : super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<LoadUserProfile>(_onLoadProfileEvent);
    on<ModifyPasswordEvent>(_onModifyPasswordEvent);
    on<UpdateProfileImageEvent>(_onUpdateProfileImageEvent);

    _authBlocSubscription = _authBloc.stream.listen((authState) {
      log('AuthState received in ProfileBloc: $authState');
      if (authState is AuthSuccess &&
          (authState.request == Request.checkUser ||
              authState.request == Request.updateUser)) {
        log('AuthSuccess: Dispatching LoadUserProfile event ');
        log('AuthSuccess update: user :::::: ${authState.user.fullName} ');
        add(LoadUserProfile(authState.user)); // Dispatch event to load profile
      } else {
        log('AuthState is not AuthSuccess: $authState');
      }
    });
  }

  void _onUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    log('ProfileBloc: UpdateProfileEvent received for userFullName: ${event.fullName}');

    final result = await _updateProfileUseCase(UserFieldsParams(
      fullName: event.fullName,
      userEmail: event.userEmail,
      userPhoneNumber: event.phoneNumber,
    ));

    result.fold(
      (failure) {
        log('Profile update failed: ${failure.message}');
        emit(ProfileUpdateFailure(message: failure.message));
      },
      (profile) {
        log('Profile updated successfully for user fullName: ${profile.fullName}');
        log('Profile updated successfully for username: ${profile.userName}');
        _authBloc.add(AuthUserUpdated(profile));
        add(LoadUserProfile(profile));
        emit(ProfileUpdateSuccess(user: profile));
      },
    );
  }

  void _onLoadProfileEvent(LoadUserProfile event, Emitter<ProfileState> emit) {
    emit(ProfileLoading());
    log('ProfileBloc: LoadUserProfile event received for user: ${event.user}');
    emit(ProfileLoadSuccess(user: event.user));
  }

  @override
  Future<void> close() {
    log('ProfileBloc: Cancelling AuthBloc subscription');
    _authBlocSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onModifyPasswordEvent(
      ModifyPasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await _updatePasswordUseCase.call(UpdatePassParams(
      currentPassword: event.currentPassword,
      newPassword: event.newPassword,
      confirmPassword: event.confirmPassword,
    ));

    result.fold(
      (error) => emit(ProfileUpdatePassFailure(message: error.message)),
      (_) {
        emit(const ProfileUpdatePassSuccess());
      },
    );
  }

  FutureOr<void> _onUpdateProfileImageEvent(
      UpdateProfileImageEvent event, Emitter<ProfileState> emit) async {
    if (event.method == 'gallery') {
      final image = await picker.fromGallery();

      if (image != null) {
        emit(ProfileLoading());
        final result = await _updateProfileImageUseCase.call(image);
        result.fold(
          (error) => emit(ProfileUpdateFailure(message: error.message)),
          (data) {
            _authBloc.add(AuthUserUpdated(data));
            emit(ProfileUpdateSuccess(user: data));
          },
        );
      }
    }
    if (event.method == 'camera') {
      final image = await picker.fromCamera();

      if (image != null) {
        emit(ProfileLoading());
        final result = await _updateProfileImageUseCase.call(image);
        result.fold(
          (error) => emit(ProfileUpdateFailure(message: error.message)),
          (data) {
            _authBloc.add(AuthUserUpdated(data));
            emit(ProfileUpdateSuccess(user: data));
          },
        );
      }
    }
  }
}
