import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
        emit(MapLoaded(position: position));
      } catch (e) {
        emit(MapError(message: e.toString()));
      }
    });
  }
}
