import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/screens/sign_in_screen.dart';
import 'package:mafuriko/features/onboarding/screens/onboarding_view.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Paths.initialPath,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Paths.signIn,
          name: Paths.signIn,
          builder: (context, state) {
            return const SignInScreen();
          },
        )
      ],
    ),
  ],
);
