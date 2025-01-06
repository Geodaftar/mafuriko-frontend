import 'package:flutter/material.dart';
import 'package:mafuriko/features/home/presentation/widgets/botton_nav_bar.dart';

class ScaffoldApp extends StatefulWidget {
  const ScaffoldApp({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ScaffoldApp> createState() => _ScaffoldAppState();
}

class _ScaffoldAppState extends State<ScaffoldApp> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        body: widget.child,
      ),
    );
  }
}
