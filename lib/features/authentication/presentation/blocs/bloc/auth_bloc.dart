import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/usecases/get_cache.dart';
import 'package:mafuriko/features/authentication/domain/usecases/login_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final GetCachedUser getCachedUser;

  AuthBloc({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.getCachedUser,
  }) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<LogOutEvent>(_onLogOutEvent);
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, UserEntity> result = await signUpUseCase(
      SignUpParams(
        email: event.userEmail,
        fullName: event.userName,
        phoneNumber: event.userNumber,
        password: event.userPassword,
        confirmPassword: event.confirmPassword,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, UserEntity> result = await loginUseCase(
      LogInParams(
        email: event.userEmail,
        password: event.userPassword,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    final failureOrUser = await getCachedUser(NoParams());

    log('failureOrUser : $failureOrUser');

    failureOrUser.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) {
        log('user id::::::::::: ${user.id}');
        log('user name::::::::::: ${user.userName}');
        log('user email::::::::::: ${user.userEmail}');

        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> _onLogOutEvent(
      LogOutEvent event, Emitter<AuthState> emit) async {
    await getCachedUser.repository.logout();
    emit(AuthUnauthenticated());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Server Failure';
      case CacheFailure _:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}

class ToggleCubit extends Cubit<bool> {
  ToggleCubit() : super(true);

  void toggler() {
    emit(!state);
  }
}
