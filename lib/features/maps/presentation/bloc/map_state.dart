part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState({this.position, this.place = const []});
  final Position? position;
  final List<Placemark>? place;

  @override
  List<Object?> get props => [position, place];
}

final class MapInitialState extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  const MapLoaded({super.position, super.place});

  @override
  List<Object?> get props => [position, place];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object> get props => [message];
}
