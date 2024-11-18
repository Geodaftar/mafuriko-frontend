import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/features/send/data/datasources/remote/alert_remote_data_source.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/domain/repositories/alert_repository.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class AlertRepositoryImpl implements AlertRepository {
  final AlertRemoteDataSource _remoteDataSource;

  AlertRepositoryImpl({required AlertRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
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
  }) async {
    try {
      final data = await _remoteDataSource.postAlert(
        uid: uid,
        description: description,
        position: position,
        location: location,
        intensity: intensity,
        category: alertCategory,
        image: image,
        temp: temperature,
        weather: weather,
      );
      return Right(data);
    } on ServerException catch (e) {
      log('posting alert exception error message::::::::: ${e.message}');
      log('posting alert exception error statusCode::::::::: ${e.statusCode}');
      log('posting alert exception error code::::::::: ${e.code}');
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<AlertEntity>>> fetchAlerts() async {
    try {
      final data = await _remoteDataSource.fetchAlerts();
      return Right(data);
    } on ServerException catch (e) {
      log('fetching alert exception error message::::::::: ${e.message}');
      log('fetching alert exception error statusCode::::::::: ${e.statusCode}');
      log('fetching alert exception error code::::::::: ${e.code}');
      return Left(ServerFailure(message: e.message));
    }
  }
}
