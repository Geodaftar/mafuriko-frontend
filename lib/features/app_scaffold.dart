import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
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
  int _selectedIndex = 0;

  final List<String> _routes = [Paths.home, Paths.mapScreen];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Naviguer vers les routes définies
    context.goNamed(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(
          index: _selectedIndex,
          onTap: (i) {
            _onItemTapped(i);
          },
        ),
        body: widget.child,
      ),
    );
  }
}
