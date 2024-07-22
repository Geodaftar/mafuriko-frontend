import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/screens/login_screen.dart';
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
      redirect: (context, state) {
        final authBloc = context.read<AuthBloc>();
        final bool isAuthenticated = authBloc.state is AuthSuccess;

        if (!isAuthenticated && state.path != Paths.initialPath) {
          return state.namedLocation(Paths.initialPath);
        } else if (isAuthenticated && state.path == Paths.initialPath) {
          return state.namedLocation(Paths.home);
        }
        return null;
      },
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
  ],
);
