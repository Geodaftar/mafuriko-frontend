import 'package:equatable/equatable.dart';

class AlertEntity extends Equatable {
  final String id;
  final String? image;
  final Map<String, dynamic>? floodLocation;
  final String alertType;
  final String? floodScene;
  final String? floodDescription;
  final String? weather;
  final String? temperature;
  final String? postBy;
  final String? status;
  final DateTime? postAt;

  const AlertEntity({
    required this.id,
    this.floodLocation,
    this.image,
    this.alertType = 'Inondation',
    this.floodScene,
    this.floodDescription,
    this.weather,
    this.temperature,
    this.postBy,
    this.status,
    this.postAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      image,
      floodLocation,
      alertType,
      floodScene,
      floodDescription,
      weather,
      temperature,
      postBy,
      status,
      postAt,
    ];
  }
}


/*

  {
            // "floodLocation": {
            //     "longitude": "5.3597",
            //     "latitude": "-3.9618"
            // },
            "_id": "66dce67424a756792c024686",
            // "floodScene": " Inondation à la palmeraie entre carrefour commissariat et le super marché chic shop de la palmeraie ",
            "floodDate": "2024-06-13T00:00:00.000Z",
            // "floodDescription": "",
            "floodIntensity": "Elevée",
            // "floodImage": "https://mafu.ams3.cdn.digitaloceanspaces.com/images_flood/inondation_palmeraie.jpg"
        },

*/ 