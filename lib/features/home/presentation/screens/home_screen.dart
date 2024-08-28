import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mafuriko/features/home/presentation/components/home_sections.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     context.read<MapBloc>().add(LoadUserLocationEvent());
    //   },
    // );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapBloc = context.read<MapBloc>();
      if (mapBloc.isClosed) {
        return;
      }
      mapBloc.add(LoadUserLocationEvent());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          // physics: FixedExtentScrollPhysics(),
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const ReportCount(),
                  const MapSection(),
                  const AlertsSection(),
                  const ActuSection(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
