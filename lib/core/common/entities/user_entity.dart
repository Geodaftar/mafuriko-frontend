class UserEntity {
  final String? id;
  final String? userEmail;
  final String? userName;
  final String? fullName;

  final String? userNumber;
  final String? userPassword;
  final String? confirmPassword;
  final String? image;
  final String? token;

  UserEntity({
    this.id,
    this.userEmail,
    this.fullName,
    this.userName,
    this.userNumber,
    this.userPassword,
    this.confirmPassword,
    this.image,
    this.token,
  });
}
