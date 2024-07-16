import 'dart:convert';

class UserEntity {
  final String? id;
  final String? userEmail;
  final String? userName;

  final String? userNumber;
  final String? userPassword;
  final String? confirmPassword;
  final String? image;

  UserEntity({
    this.id,
    this.userEmail,
    this.userName,
    this.userNumber,
    this.userPassword,
    this.confirmPassword,
    this.image,
  });

  UserEntity copyWith({
    String? id,
    String? userEmail,
    String? userName,
    String? userNumber,
    String? userPassword,
    String? confirmPassword,
    String? image,
  }) {
    return UserEntity(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      userNumber: userNumber ?? this.userNumber,
      userPassword: userPassword ?? this.userPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'userEmail': userEmail,
        'userName': userName,
        'userNumber': userNumber,
        'userPassword': userPassword,
        'image': image,
      };

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      userEmail: map['userEmail'],
      userName: map['userName'],
      userNumber: map['userNumber'],
      userPassword: map['userPassword'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(id: $id, userEmail: $userEmail, userName: $userName,  userNumber: $userNumber, userPassword: $userPassword, image: $image)';
  }
}
