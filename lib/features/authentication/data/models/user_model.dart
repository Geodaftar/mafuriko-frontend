import 'package:mafuriko/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String? id,
    super.image,
    required String email,
    required String fullName,
    required String phoneNumber,
  }) : super(
          userEmail: email,
          userName: fullName,
          userNumber: phoneNumber,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phoneNumber: json['userNumber'],
      image: json['image'],
    );
  }
}
