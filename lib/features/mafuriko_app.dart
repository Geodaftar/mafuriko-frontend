import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/core/routes/routes.dart';
import 'package:mafuriko/shared/theme/ziva_theme.dart';

class MafurikoApp extends StatelessWidget {
  const MafurikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390.w, 844.h),
      builder: (context, child) => MaterialApp.router(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        title: "Mafuriko",
        routerConfig: router,
      ),
    );
  }
}
