// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lottie/lottie.dart';
// import 'package:mafuriko/core/routes/constant_path.dart';
// import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
// import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   navigate(context);
  // }

  // void navigate(BuildContext context) {
  //   context.read<AuthBloc>().add(CheckAuthEvent());
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     context.read<AuthBloc>().stream.listen((state) {
  //       log('ev nav${state}');
  //       if (state is AuthSuccess) {
  //         context.read<ProfileBloc>().add(LoadUserProfile(state.user));
  //         context.pushNamed(Paths.home);
  //       } else {
  //         debugPrint('empty');
  //         context.pushNamed(Paths.initialPath);
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
