import 'dart:convert';

import 'package:mafuriko/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    String? profile,
    super.userEmail,
    required String fullName,
    super.userNumber,
    super.token,
  }) : super(
          userName: fullName,
          image: profile,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    final firstName = data['userFirstName'] ?? '';
    final lastName = data['userLastName'] ?? '';
    final name = firstName.isNotEmpty || lastName.isNotEmpty
        ? '$firstName $lastName'
        : json['fullName'] ?? '';

    return UserModel(
      id: data['_id'],
      userEmail: data['userEmail'] ?? '',
      fullName: name.isNotEmpty ? name : 'No Name Provided',
      userNumber: data['userNumber'] ?? '',
      profile: data['image'],
      token: json['token'],
    );
  }
  String toJson() => json.encode(<String, dynamic>{
        "_id": id,
        "fullName": userName,
        "userEmail": userEmail,
        "userNumber": userNumber,
        "image": image,
        "token": token
      });
}
