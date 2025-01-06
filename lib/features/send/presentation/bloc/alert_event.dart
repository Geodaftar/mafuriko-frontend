part of 'alert_bloc.dart';

sealed class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object> get props => [];
}

final class FetchAlerts extends AlertEvent {
  const FetchAlerts();
}

final class PostAlert extends AlertEvent {
  final String uid;
  final String sceneName;
  final LatLng floodLocation;
  final String floodDescription;
  final String floodIntensity;
  final String category;
  final String temperature;
  final String weather;
  final XFile? floodImage;

  const PostAlert({
    required this.uid,
    required this.sceneName,
    required this.floodLocation,
    required this.floodDescription,
    required this.floodIntensity,
    required this.category,
    required this.temperature,
    required this.weather,
    this.floodImage,
  });
}
