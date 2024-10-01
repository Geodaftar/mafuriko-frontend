import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_password_usecase.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUseCase _updateProfileUseCase;
  final UpdatePasswordUseCase _updatePasswordUseCase;
  final AuthBloc _authBloc;
  late StreamSubscription _authBlocSubscription;

  ProfileBloc(
    this._updatePasswordUseCase,
    this._updateProfileUseCase,
    this._authBloc,
  ) : super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<LoadUserProfile>(_onLoadProfileEvent);
    on<ModifyPasswordEvent>(_onModifyPasswordEvent);

    _authBlocSubscription = _authBloc.stream.listen((authState) {
      log('AuthState received in ProfileBloc: $authState');
      if (authState is AuthSuccess &&
          (authState.request == Request.checkUser ||
              authState.request == Request.updateUser)) {
        log('AuthSuccess: Dispatching LoadUserProfile event');
        add(LoadUserProfile(authState.user)); // Dispatch event to load profile
      } else {
        log('AuthState is not AuthSuccess: $authState');
      }
    });
  }

  void _onUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    log('ProfileBloc: UpdateProfileEvent received for userName: ${event.userName}');

    final result = await _updateProfileUseCase(UserFieldsParams(
      userName: event.userName,
      userEmail: event.userEmail,
      userPhoneNumber: event.phoneNumber,
    ));

    result.fold(
      (failure) {
        log('Profile update failed: ${failure.message}');
        emit(ProfileUpdateFailure(message: failure.message));
      },
      (profile) {
        log('Profile updated successfully for user: ${profile.userName}');
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
}
