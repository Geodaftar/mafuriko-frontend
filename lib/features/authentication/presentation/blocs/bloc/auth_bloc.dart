import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/usecases/check_number_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/get_cache.dart';
import 'package:mafuriko/features/authentication/domain/usecases/login_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/modify_pass_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/send_opt_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final GetCachedUser getCachedUser;
  final CheckNumberUseCase checkNumberUseCase;
  final SendOtpCodeUseCase sendOtpCodeUseCase;
  final VerifyOtpCode verifyOtpCode;
  final ModifyPassUseCase modifyPassUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.getCachedUser,
    required this.checkNumberUseCase,
    required this.sendOtpCodeUseCase,
    required this.verifyOtpCode,
    required this.modifyPassUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<CheckPhoneNumberEvent>(_onCheckPhoneNumberEvent);
    on<VerifyOTPEvent>(_onVerifyOTPEvent);
    on<UpdateForgotPasswordEvent>(_onUpdateForgotPasswordEvent);
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
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user, request: Request.signup)),
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
      (user) => emit(AuthSuccess(user: user, request: Request.login)),
    );
  }

  Future<void> _onCheckAuthEvent(
      CheckAuthEvent event, Emitter<AuthState> emit) async {
    final failureOrUser = await getCachedUser(NoParams());

    log('failureOrUser : $failureOrUser');

    failureOrUser.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthSuccess(user: user, request: Request.checkUser)),
    );
  }

  Future<void> _onLogOutEvent(
      LogOutEvent event, Emitter<AuthState> emit) async {
    final isLoggedOut = await logoutUseCase.call();

    print(
        'loggedOut event state before emitting : $state  \n bool*****::::$isLoggedOut');
    if (isLoggedOut) {
      emit(AuthUnauthenticated());

      // mafu01@infos.com
    }
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

  void _onCheckPhoneNumberEvent(
      CheckPhoneNumberEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, bool> response =
        await checkNumberUseCase.call(event.userNumber);

    response.fold(
      (err) => emit(AuthFailure(message: err.message)),
      (val) async {
        emit(AuthCheckNumSuccess(val: val));

        if (val) {
          await sendOtpCodeUseCase.execute(
            event.userNumber,
            completedVerification: event.completedVerification,
            failedVerification: event.failedVerification,
            onCodeSend: event.onCodeSend,
            codeAutoRetrievalTimeout: event.codeAutoRetrievalTimeout,
          );
        }
      },
    );
  }

  void _onVerifyOTPEvent(VerifyOTPEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, bool> response = await verifyOtpCode.call(
        CheckOTPParams(verificationId: event.vId, smsCode: event.otpCode));

    response.fold(
      (err) => emit(AuthFailure(message: err.message)),
      (res) {
        emit(SuccessOTP(val: res, userNumber: event.phoneNumber));
      },
    );
  }

  void _onUpdateForgotPasswordEvent(
      UpdateForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final phoneNumber = (state as SuccessOTP).userNumber;
    emit(AuthLoading());

    final Either<Failure, UserEntity> response =
        await modifyPassUseCase.call(ModifyPassParams(
      phoneNumber: phoneNumber,
      password: event.newPass,
      confirmPassword: event.newPassConfirm,
    ));

    response.fold(
      (err) => emit(AuthFailure(message: err.message)),
      (user) {
        emit(AuthSuccess(user: user, request: Request.updatePassword));
      },
    );
  }
}

class ToggleCubit extends Cubit<bool> {
  ToggleCubit() : super(true);

  void toggler() {
    emit(!state);
  }
}
