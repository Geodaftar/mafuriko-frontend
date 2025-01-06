part of 'alert_bloc.dart';

enum AlertReq { refresh, sendAlert, unknown }

sealed class AlertState extends Equatable {
  const AlertState({this.alerts = const [], this.message});

  final List<AlertEntity> alerts;
  final String? message;

  @override
  List<Object?> get props => [alerts, message];
}

final class AlertInitial extends AlertState {}

final class AlertLoading extends AlertState {}

final class SuccessAlert extends AlertState {
  final AlertReq reqType;
  const SuccessAlert({
    required List<AlertEntity> alertsFetched,
    this.reqType = AlertReq.unknown,
  }) : super(alerts: alertsFetched);

  @override
  List<Object?> get props => [alerts];
}

final class FailureAlert extends AlertState {
  const FailureAlert({
    required String messageF,
    super.alerts = const [],
  }) : super(message: messageF);

  @override
  List<Object?> get props => [message];
}
