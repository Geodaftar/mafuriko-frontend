import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mafuriko/features/maps/domain/usecases/get_user_location_usecase.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetUserLocationUseCase getUserLocationUseCase;

  MapBloc(this.getUserLocationUseCase) : super(MapInitialState()) {
    on<LoadUserLocationEvent>((event, emit) async {
      emit(MapLoading());
      try {
        final position = await getUserLocationUseCase.call();

        List<Placemark> placeMarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        emit(MapLoaded(position: position, place: placeMarks));
      } on PlatformException catch (e) {
        emit(MapError(message: e.message.toString()));
      }
    });
  }
}
