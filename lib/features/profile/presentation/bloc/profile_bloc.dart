import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/profile/domain/usecases/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUseCase _updateProfileUseCase;
  final AuthBloc _authBloc;
  late StreamSubscription _authBlocSubscription;

  ProfileBloc(
    this._updateProfileUseCase,
    this._authBloc,
  ) : super(ProfileInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<LoadUserProfile>(_onLoadProfileEvent);

    // Listening to AuthBloc's state stream ||||||| doesn't work ==> need to improve

    _authBlocSubscription = _authBloc.stream.listen((authState) {
      log('AuthState received in ProfileBloc: $authState');
      if (authState is AuthSuccess && authState.request == Request.checkUser) {
        log('AuthSuccess: Dispatching LoadUserProfile event');
        add(LoadUserProfile(authState.user)); // Dispatch event to load profile
      } else {
        log('AuthState is not AuthSuccess: $authState');
      }
    });
  }

  void _onUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    // emit(ProfileLoading());
    // log('ProfileBloc: UpdateProfileEvent received for userName: ${event.userName}');

    // final result =
    await _updateProfileUseCase(UserFieldsParams(
      userName: event.userName,
      userEmail: event.userEmail,
      userPhoneNumber: event.phoneNumber,
    ));

    // result.fold(
    //   (failure) {
    //     log('Profile update failed: ${failure.message}');
    //     emit(ProfileUpdateFailure(message: failure.message));
    //   },
    //   (profile) {
    //     log('Profile updated successfully for user: ${profile.userName}');
    //     emit(ProfileUpdateSuccess(user: profile));
    //   },
    // );

    //! to implement
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
}
