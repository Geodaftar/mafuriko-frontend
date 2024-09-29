import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/domain/usecases/fetch_alert_usecase.dart';
import 'package:mafuriko/features/send/domain/usecases/post_alert_usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final FetchAlertUseCase fetchAlertUseCase;
  final PostAlertUseCase postAlertUseCase;

  AlertBloc(
    this.fetchAlertUseCase,
    this.postAlertUseCase,
  ) : super(AlertInitial()) {
    on<FetchAlerts>(_onFetchAlertEvent);
    on<PostAlert>(_onPostAlertEvent);
  }

  FutureOr<void> _onFetchAlertEvent(
      FetchAlerts event, Emitter<AlertState> emit) async {
    emit(AlertLoading()); // Optional, resetting the state
    final result = await fetchAlertUseCase();

    result.fold(
      (failure) => emit(FailureAlert(
          messageF: _mapFailureToMessage(failure), alerts: const [])),
      (alerts) {
        if (alerts.isEmpty) {
          emit(const FailureAlert(messageF: 'No alerts found'));
        }
        emit(SuccessAlert(alertsFetched: alerts));
      },
    );
  }

  // Mapping the failure to a human-readable message
  String _mapFailureToMessage(Failure failure) {
    if (failure.message == 'connectionError') {
      return 'Impossible de charger les alertes, veuillez vérifier votre connexion réseau';
    } else {
      return 'Unexpected error occurred';
    }
  }

  FutureOr<void> _onPostAlertEvent(
      PostAlert event, Emitter<AlertState> emit) async {
    log('alert data from state alert bloc::::::::::::::::::::::::\n ${state.alerts} \n:::::::::::::::::::::::::::::::');
    final updatedAlerts = List<AlertEntity>.from(state.alerts);
    emit(AlertLoading());
    final result = await postAlertUseCase(AlertParams(
      sceneName: event.sceneName,
      floodLocation: event.floodLocation,
      floodDescription: event.floodDescription,
      floodIntensity: event.floodIntensity,
      floodImage: event.floodImage,
      alertCategory: event.category,
    ));

    result.fold(
      (failure) => emit(FailureAlert(messageF: _mapFailureToMessage(failure))),
      (data) {
        log('alert data from alert bloc::::::::::::::::::::::::\n $data \n:::::::::::::::::::::::::::::::');

        updatedAlerts.add(data as AlertEntity);

        emit(SuccessAlert(alertsFetched: updatedAlerts));
      },
    );
  }
}
