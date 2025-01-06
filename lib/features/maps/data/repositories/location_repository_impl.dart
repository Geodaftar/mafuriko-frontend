import 'package:geolocator/geolocator.dart';
import 'package:mafuriko/features/maps/data/services/geolocator_service.dart';
import 'package:mafuriko/features/maps/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GeolocatorService geolocatorService;

  LocationRepositoryImpl(this.geolocatorService);

  @override
  Future<Position> getCurrentPosition() async {
    return geolocatorService.getCurrentPosition();
  }
}
