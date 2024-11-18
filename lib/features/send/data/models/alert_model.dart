import 'dart:convert';

import 'package:mafuriko/features/send/domain/entities/alert_entity.dart';

class AlertModel extends AlertEntity {
  const AlertModel({
    required super.id,
    super.image,
    super.floodLocation,
    super.alertType,
    super.floodScene,
    super.floodDescription,
    super.weather,
    super.temperature,
    super.status,
    super.postBy,
    super.postAt,
  });

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    final String user = json['user'] != null
        ? '${json["user"]["userFullName"] ?? ''}'
        : 'Administrateur';

    // print('user from alert: $user');
    return AlertModel(
      id: json["_id"],
      image: json['floodImage'],
      floodLocation: Map<String, dynamic>.from(json['floodLocation']),
      alertType: json['floodCategory'],
      floodScene: json['floodScene'],
      floodDescription: json['floodDescription'],
      temperature: json['temperature'] ?? 'N/A',
      weather: json['weather'] ?? 'N/A',
      postBy: user,
      status: json['status'],
      postAt: json['floodDate'] != null
          ? DateTime.parse(json['floodDate'])
          : DateTime.now(),
    );
  }
  String toJson() => json.encode(<String, dynamic>{
        'id': id,
        'image': image,
        'floodLocation': floodLocation,
        'alertType': alertType,
        'floodScene': floodScene,
        'floodDescription': floodDescription,
        'weather': weather,
        'temperature': temperature,
        'postBy': postBy,
        'status': status,
        'postAt': postAt,
      });
}
