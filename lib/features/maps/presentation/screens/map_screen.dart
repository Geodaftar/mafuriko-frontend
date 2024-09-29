import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/presentation/bloc/alert_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/service_locator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.enabledLocation = true});
  final bool enabledLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final _customInfoWindowController = CustomInfoWindowController();

  List<Marker> _markers = [];

  bool isLoad = false;

  LatLng currentPosition = const LatLng(0.393037, 9.450152);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to use context.watch here
    _getFloodData(context);
  }

  void _getFloodData(BuildContext context) {
    final List<AlertEntity> alerts = context.watch<AlertBloc>().state.alerts;

    setState(() {
      _markers = alerts.map(
        (alert) {
          return Marker(
            icon: AssetMapBitmap(AppImages.icons.alertPinPng.path),
            markerId: MarkerId(alert.id),
            position: LatLng(
              double.parse(alert.floodLocation?['latitude']),
              double.parse(alert.floodLocation?['longitude']),
            ),
            onTap: () {
              // call custom window to display alert
              _customInfoWindowController.addInfoWindow!(
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF8EBE1),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: AppColor.primary),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.floodScene ?? 'N/A',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 12.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Inondation',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 12.sp,
                          fontFamily: AppFonts.nunito,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 56.h,
                        child: Text(
                          alert.floodDescription ?? 'N/A',
                          style: TextStyle(
                            color: AppColor.primaryGray,
                            fontSize: 10.sp,
                            fontFamily: AppFonts.nunito,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LatLng(
                  double.parse(alert.floodLocation?['latitude']),
                  double.parse(alert.floodLocation?['longitude']),
                ),
              );
            },
          );
        },
      ).toList();
    });
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapBloc>(),
      child: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError && widget.enabledLocation == false) {
            // Rediriger vers HomeScreen en cas d'erreur
            context.pushReplacementNamed(Paths.home);
          }
        },
        builder: (context, state) {
          if (state is MapLoading) {
            return GoogleMap(
              key: ValueKey(isLoad),
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: const LatLng(4.027265, -9.027265),
                zoom: widget.enabledLocation ? 15.0 : 16.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
                _controller.complete(controller);
              },
              onTap: (argument) {
                // _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: widget.enabledLocation ? _markers.toSet() : {},
              zoomGesturesEnabled: widget.enabledLocation ? true : false,
            );
          } else if (state is MapLoaded) {
            return Stack(
              children: [
                GoogleMap(
                  key: ValueKey(isLoad),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.position?.latitude ?? 0,
                        state.position?.longitude ?? 0),
                    zoom: widget.enabledLocation ? 15.0 : 16.0,
                  ),
                  // style: theme,
                  onMapCreated: (GoogleMapController controller) {
                    _customInfoWindowController.googleMapController =
                        controller;
                    _controller.complete(controller);
                  },
                  onTap: (argument) {
                    // _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: widget.enabledLocation ? _markers.toSet() : {},
                  zoomGesturesEnabled: widget.enabledLocation ? true : false,
                  scrollGesturesEnabled: widget.enabledLocation ? true : false,
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  width: 167.w,
                  height: 137.10.h,
                  offset: 60,
                ),
              ],
            );
          } else if (state is MapError) {
            return const Center(child: Text('Erreur de localisation.'));
          }
          return const Center(
            child: Text("En attente de localisation..."),
          );
        },
      ),
    );
  }
}
