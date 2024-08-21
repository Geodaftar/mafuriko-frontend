import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mafuriko/features/home/presentation/widgets/home_widget.dart';

class MapSection extends StatelessWidget {
  const MapSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Section(
            title: 'Carte',
            routeTitle: 'Voir la carte',
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 335.w,
              height: 112.h,
              child: const GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(5.400686, -3.980562), // default position
                  zoom: 10,
                ),
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                myLocationEnabled: true,
                mapType: MapType.terrain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
