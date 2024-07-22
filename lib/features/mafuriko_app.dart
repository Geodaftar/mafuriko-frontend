import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/core/routes/routes.dart';
import 'package:mafuriko/features/onboarding/cubit/count_cubit.dart';
import 'package:mafuriko/shared/theme/ziva_theme.dart';
import '../service_locator.dart';
import 'authentication/presentation/blocs/bloc/auth_bloc.dart';

class MafurikoApp extends StatelessWidget {
  const MafurikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CountCubit(),
          ),
          BlocProvider(
            create: (_) => sl<AuthBloc>()..add(CheckAuthEvent()),
          ),
          BlocProvider(
            create: (context) => ToggleCubit(),
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          title: "Mafuriko",
          routerConfig: router,
        ),
      ),
    );
  }
}
