import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/shared/theme/ziva_theme.dart';

class MafurikoApp extends StatelessWidget {
  const MafurikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) =>  MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        title: "Mafuriko",
        home: const Scaffold(
          body: Center(
            child: Text('Mafuriko'),
          ),
        ),
      ),
    );
  }
}
