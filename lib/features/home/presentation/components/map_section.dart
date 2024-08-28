import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/maps/presentation/screens/map_screen.dart';
import 'package:mafuriko/service_locator.dart';

class MapSection extends StatelessWidget {
  const MapSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapBloc>()..add(LoadUserLocationEvent()),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const Section(
              title: 'Carte',
              routeTitle: 'Voir la carte',
              // route: Paths.mapScreen,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 335.w,
                height: 112.h,
                child: const MapScreen(
                  enabledLocation: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
