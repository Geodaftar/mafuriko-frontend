import 'package:dartz/dartz.dart';
import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';
import 'package:mafuriko/features/send/domain/repositories/alert_repository.dart';
import 'package:mafuriko/shared/errors/failures.dart';

class FetchAlertUseCase {
  final AlertRepository repository;

  FetchAlertUseCase(this.repository);

  Future<Either<Failure, List<AlertEntity>>> call() async {
    return await repository.fetchAlerts();
  }
}
