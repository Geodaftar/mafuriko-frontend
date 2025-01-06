import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/shared/errors/failures.dart';

abstract interface class AlertRepository {
  Future<Either<Failure, AlertEntity?>> postAlert({
    required String uid,
    required LatLng position,
    required String location,
    required String description,
    required String intensity,
    required String alertCategory,
    required String temperature,
    required String weather,
    XFile? image,
  });
  Future<Either<Failure, List<AlertEntity>>> fetchAlerts();
}
