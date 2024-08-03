import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
// import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/screens/forgot_password.dart';
import 'package:mafuriko/features/authentication/presentation/screens/verify_number.dart';
import 'package:mafuriko/features/authentication/presentation/screens/login_screen.dart';
import 'package:mafuriko/features/authentication/presentation/screens/otp_screen.dart';
import 'package:mafuriko/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:mafuriko/features/home/presentation/screens/home_screen.dart';
import 'package:mafuriko/features/onboarding/screens/onboarding_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Paths.initialPath,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingView();
      },
      // redirect: (context, state) {
      //   final authBloc = context.read<AuthBloc>();
      //   final bool isAuthenticated = authBloc.state is AuthSuccess;

      //   debugPrint('Current path: ${state.path}');
      //   debugPrint('Is authenticated: $isAuthenticated');
      //   debugPrint('AuthBloc state: ${authBloc.state.runtimeType}');

      //   if (!isAuthenticated && state.path != Paths.initialPath) {
      //     return Paths.initialPath;
      //   } else if (isAuthenticated && state.path == Paths.initialPath) {
      //     return '/${Paths.home}';
      //   }
      //   return null;
      // },
    ),
    GoRoute(
      path: '/${Paths.signUp}',
      name: Paths.signUp,
      builder: (context, state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/${Paths.login}',
      name: Paths.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/${Paths.home}',
      name: Paths.home,
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/${Paths.verifyNumber}',
      name: Paths.verifyNumber,
      builder: (context, state) {
        return const VerifyNumberScreen();
      },
    ),
    GoRoute(
      path: '/${Paths.forgotPassword}',
      name: Paths.forgotPassword,
      builder: (context, state) {
        return const ForgotPasswordScreen();
      },
    ),
    GoRoute(
      path: '/${Paths.otpScreen}',
      name: Paths.otpScreen,
      builder: (context, state) {
        final List data = state.extra as List;
        return OTPScreen(
          vId: data[1],
          phoneNumber: data[0],
        );
      },
    ),
  ],
);
