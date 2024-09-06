import 'dart:convert';

import 'package:mafuriko/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    String? profile,
    required String email,
    required String fullName,
    required String phoneNumber,
  }) : super(
          userEmail: email,
          userName: fullName,
          userNumber: phoneNumber,
          image: profile,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = '${json['userFirstName']} ${json['userLastName']}';
    return UserModel(
      id: json['_id'],
      email: json['userEmail'],
      fullName: json['fullName'] ?? name,
      phoneNumber: json['userNumber'],
      profile: json['image'],
    );
  }
  String toJson() => json.encode(<String, dynamic>{
        "_id": id,
        "fullName": userName,
        "userEmail": userEmail,
        "userNumber": userNumber,
        "image": image,
      });
}
