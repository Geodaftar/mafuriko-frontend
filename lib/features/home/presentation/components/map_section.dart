import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/home/presentation/cubit/navigation_cubit.dart';
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
        padding: EdgeInsets.only(right: 5.w),
        child: Column(
          children: [
            const Section(
              title: 'Carte',
              routeTitle: 'Voir la carte',
              // route: Paths.mapScreen,
            ),
            Padding(
              padding: EdgeInsets.only(right: 13.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: SizedBox(
                  height: 112.h,
                  child: InkWell(
                    onTap: () {
                      context.read<NavigationCubit>().updateIndex(1);
                    },
                    child: Stack(
                      children: [
                        // MapScreen, que tu veux afficher mais désactiver l'interaction
                        const MapScreen(
                          enabledLocation: false,
                        ),
                        // Container transparent pour capturer les clics et s'assurer que l'InkWell les détecte
                        Positioned.fill(
                          child: Container(
                            color: Colors
                                .transparent, // Transparence pour capturer le clic
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
