import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/domain/repositories/alert_repository.dart';

import 'package:mafuriko/shared/base/usecase.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class PostAlertUseCase extends UseCase<AlertEntity?, AlertParams> {
  final AlertRepository repository;

  PostAlertUseCase(this.repository);

  @override
  Future<Either<Failure, AlertEntity?>> call(AlertParams params) async {
    return await repository.postAlert(
      position: params.floodLocation,
      location: params.sceneName,
      description: params.floodDescription,
      intensity: params.floodIntensity,
      alertCategory: params.alertCategory,
      image: params.floodImage,
    );
  }
}

class AlertParams {
  final String sceneName;
  final LatLng floodLocation;
  final String floodDescription;
  final String floodIntensity;
  final String alertCategory;
  final XFile? floodImage;

  AlertParams({
    required this.sceneName,
    required this.floodLocation,
    required this.floodDescription,
    required this.floodIntensity,
    required this.alertCategory,
    this.floodImage,
  });
}

/*
 floodScene:req.body.floodScene,
floodLocation: {
    longitude: req.body.longitude,
    latitude: req.body.latitude
},
floodDescription: req.body.floodDescription,
floodIntensity: req.body.floodIntensity,
floodImage: req.body.floodImage
*/