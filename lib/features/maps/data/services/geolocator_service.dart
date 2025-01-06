import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérification si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    // Vérification des permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Les permissions de localisation sont refusées.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Les permissions de localisation sont refusées en permanence.');
    }

    // Récupération de la position actuelle
    return await Geolocator.getCurrentPosition();
  }
}
