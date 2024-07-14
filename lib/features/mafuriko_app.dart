import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/core/routes/routes.dart';
import 'package:mafuriko/features/onboarding/cubit/count_cubit.dart';
import 'package:mafuriko/shared/theme/ziva_theme.dart';

class MafurikoApp extends StatelessWidget {
  const MafurikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => BlocProvider(
        create: (context) => CountCubit(),
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
