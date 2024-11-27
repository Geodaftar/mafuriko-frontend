import 'dart:convert';
import 'dart:developer';

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
    String usr = "";
    if (json['user'] != null) {
      if (json["user"]["userFullName"] != null &&
          json["user"]["userFullName"] != '') {
        usr = json["user"]["userFullName"];
      } else if (json["user"]["userEmail"] != null &&
          json["user"]["userEmail"] != '') {
        usr = json["user"]["userEmail"];
      } else {
        usr = '';
      }
    }
    log("User- alert :  $usr");
    final String user = usr;
    // json['user'] != null
    //     ? '${json["user"]["userFullName"] ?? ''}' //utilisation de l'email de l'utilisateur dans le cas où le fullname est vide
    //     : 'Administrateur';

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
