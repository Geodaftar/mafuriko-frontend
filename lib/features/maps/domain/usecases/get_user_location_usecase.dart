import 'package:geolocator/geolocator.dart';
import 'package:mafuriko/features/maps/domain/repositories/location_repository.dart';

class GetUserLocationUseCase {
  final LocationRepository repository;

  GetUserLocationUseCase(this.repository);

  Future<Position> call() {
    return repository.getCurrentPosition();
  }
}
