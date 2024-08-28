import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:latlong2/latlong.dart';
import 'package:mafuriko/core/constant_secret.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/maps/presentation/bloc/map_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/service_locator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.enabledLocation = true});
  final bool enabledLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // _determinePosition();
    _alignPositionOnUpdate = AlignOnUpdate.always;
    _alignPositionStreamController = StreamController<double?>();
    // context.read<MapBloc>().add(LoadUserLocationEvent());
  }

  AlignOnUpdate? _alignPositionOnUpdate;
  StreamController<double?>? _alignPositionStreamController;

  @override
  void dispose() {
    _mapController.dispose();
    _alignPositionStreamController?.close();
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is MapLoaded) {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialZoom: 14,
                // backgroundColor: Colors.black,
                cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(
                    const LatLng(-90, -180),
                    const LatLng(90, 180),
                  ),
                ),
                onPositionChanged: (MapCamera camera, bool hasGesture) {
                  if (hasGesture &&
                      _alignPositionOnUpdate != AlignOnUpdate.never) {
                    setState(
                      () => _alignPositionOnUpdate = AlignOnUpdate.never,
                    );
                  }
                },
              ),
              children: [
                TileLayer(
                  additionalOptions: {
                    'accessToken': Secrets.accessToken,
                    'id': 'mapbox.mapbox-streets-v7',
                  },
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/${Secrets.userId}/${Secrets.styleId}/tiles/256/{z}/{x}/{y}@2x?access_token=${Secrets.accessToken}',
                  maxZoom: 19,
                  userAgentPackageName: 'com.geodaftar.mafuriko',
                ),
                MarkerLayer(
                  markers: widget.enabledLocation == false
                      ? []
                      : [
                          Marker(
                            width: 70.w,
                            height: 70.h,
                            point: const LatLng(0.3956, 9.4543),
                            child: CircleAvatar(
                              backgroundColor: const Color(0x857A4411),
                              child: Icon(
                                size: 38.dm,
                                Icons.flood_outlined,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Marker(
                            width: 70.w,
                            height: 70.h,
                            point: const LatLng(0.3823, 9.4673),
                            child: CircleAvatar(
                              backgroundColor: const Color(0x857A4411),
                              child: Icon(
                                size: 38.dm,
                                Icons.flood_outlined,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                          Marker(
                            width: 70.w,
                            height: 70.h,
                            point: const LatLng(0.4003, 9.5306),
                            child: CircleAvatar(
                              backgroundColor: const Color(0x857A4411),
                              child: Icon(
                                size: 38.dm,
                                Icons.flood_outlined,
                                color: AppColor.black,
                              ),
                            ),
                          ),
                        ],
                ),
                CurrentLocationLayer(
                  alignPositionStream: _alignPositionStreamController?.stream,
                  alignPositionOnUpdate: _alignPositionOnUpdate,
                ),
                widget.enabledLocation
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FloatingActionButton(
                            backgroundColor: AppColor.primary,
                            shape: const CircleBorder(),
                            onPressed: () {
                              // Align the location marker to the center of the map widget
                              // on location update until user interact with the map.
                              setState(
                                () => _alignPositionOnUpdate =
                                    AlignOnUpdate.always,
                              );
                              // Align the location marker to the center of the map widget
                              // and zoom the map to level 18.
                              _alignPositionStreamController?.add(14);
                            },
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
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
