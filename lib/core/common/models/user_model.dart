import 'dart:convert';

import 'package:mafuriko/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    String? profile,
    super.userEmail,
    String? userFullName,
    super.userName,
    super.userNumber,
    super.token,
  }) : super(
          fullName: userFullName,
          image: profile,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return UserModel(
      id: data['_id'],
      userEmail: data['userEmail'] ?? '',
      userFullName: data['userFullName'],
      userName: data['userName'],
      userNumber: data['userNumber'] ?? '',
      profile: data['image'],
      token: json['token'],
    );
  }
  String toJson() => json.encode(<String, dynamic>{
        "_id": id,
        "userFullName": fullName,
        "userName": userName,
        "userEmail": userEmail,
        "userNumber": userNumber,
        "image": image,
        "token": token
      });
}
