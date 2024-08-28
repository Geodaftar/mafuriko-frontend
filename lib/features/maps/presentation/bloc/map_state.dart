part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitialState extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Position position;

  const MapLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object> get props => [message];
}
