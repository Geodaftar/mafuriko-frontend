import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/app_scaffold.dart';
// import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/screens/forgot_password.dart';
import 'package:mafuriko/features/authentication/presentation/screens/verify_number.dart';
import 'package:mafuriko/features/authentication/presentation/screens/login_screen.dart';
import 'package:mafuriko/features/authentication/presentation/screens/otp_screen.dart';
import 'package:mafuriko/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:mafuriko/features/home/presentation/screens/alert_detail_screen.dart';
import 'package:mafuriko/features/home/presentation/screens/alerts_list_screen.dart';
import 'package:mafuriko/features/home/presentation/screens/home_screen.dart';
import 'package:mafuriko/features/maps/presentation/screens/map_screen.dart';
import 'package:mafuriko/features/onboarding/screens/onboarding_view.dart';
import 'package:mafuriko/features/profile/presentation/screens/modify_password_screen.dart';
import 'package:mafuriko/features/profile/presentation/screens/notification_settings_screen.dart';
import 'package:mafuriko/features/profile/presentation/screens/personal_info_screen.dart';
import 'package:mafuriko/features/profile/presentation/screens/profile_screen.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/presentation/screens/send_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Paths.initialPath,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingView();
      },
      routes: [
        GoRoute(
          path: Paths.signUp,
          name: Paths.signUp,
          builder: (context, state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: Paths.login,
          name: Paths.login,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return ScaffoldApp(child: child);
          },
          routes: [
            GoRoute(
                path: Paths.home,
                name: Paths.home,
                builder: (context, state) {
                  return const HomeScreen();
                },
                routes: [
                  GoRoute(
                    path: Paths.alertsScreen,
                    name: Paths.alertsScreen,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: const AlertsListScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        path: Paths.alertDetailScreen,
                        name: Paths.alertDetailScreen,
                        pageBuilder: (context, state) {
                          final AlertEntity alert = state.extra as AlertEntity;

                          return CustomTransitionPage(
                            key: state.pageKey,
                            child: AlertDetailScreen(
                              alert: alert,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ]),
            GoRoute(
              path: Paths.mapScreen,
              name: Paths.mapScreen,
              builder: (context, state) {
                return const MapScreen();
              },
            ),
            GoRoute(
              path: Paths.send,
              name: Paths.send,
              builder: (context, state) {
                return const SendScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: Paths.verifyNumber,
          name: Paths.verifyNumber,
          builder: (context, state) {
            return const VerifyNumberScreen();
          },
        ),
        GoRoute(
          path: Paths.forgotPassword,
          name: Paths.forgotPassword,
          builder: (context, state) {
            return const ForgotPasswordScreen();
          },
        ),
        GoRoute(
          path: Paths.otpScreen,
          name: Paths.otpScreen,
          builder: (context, state) {
            final List data = state.extra as List;
            return OTPScreen(
              vId: data[1],
              phoneNumber: data[0],
            );
          },
        ),
        GoRoute(
          path: Paths.profileScreen,
          name: Paths.profileScreen,
          builder: (context, state) {
            return const ProfileScreen();
          },
          routes: [
            GoRoute(
              path: Paths.persoInfos,
              name: Paths.persoInfos,
              builder: (context, state) {
                debugPrint('actual route path: ${state.uri}');
                return const PersonalInfoScreen();
              },
            ),
            GoRoute(
              path: Paths.notificationSettings,
              name: Paths.notificationSettings,
              builder: (context, state) {
                debugPrint('actual route path: ${state.uri}');
                return const NotificationSettingsScreen();
              },
            ),
            GoRoute(
              path: Paths.modifyPassword,
              name: Paths.modifyPassword,
              builder: (context, state) {
                debugPrint('actual route path: ${state.uri}');
                return const ModifyPasswordScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
