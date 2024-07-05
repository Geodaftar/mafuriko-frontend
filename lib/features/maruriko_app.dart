import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MafurikoApp extends StatelessWidget {
  const MafurikoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Mafuriko",
        home: Scaffold(body: Center(child: Text('Mafuriko'),),),
      ),
    );
  }
}
