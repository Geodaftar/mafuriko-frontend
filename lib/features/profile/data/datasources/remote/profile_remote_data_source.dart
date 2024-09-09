import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mafuriko/core/common/models/user_model.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> updateUser({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
  });

  Future<bool> updatePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  const ProfileRemoteDataSourceImpl();

  @override
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    var dio = Dio();
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "userPassword": currentPassword,
        "usernewPassword": newPassword,
        "usernewPasswordC": currentPassword,
      });

      final response = await dio.request(
        'https://mafu-back.vercel.app/users/forgot-password',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log("DioException occurred: ${e.message}");
      log('DioException occurred: ${e.response?.data}');
      log('Status code: ${e.response?.statusCode}');
      log('Headers: ${e.response?.headers}');
      log('Request data: ${e.requestOptions.data}');
      throw ServerException(message: e.toString());
    } catch (e) {
      log("An error occurred: $e");
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> updateUser({
    String? userName,
    String? userEmail,
    String? userPhoneNumber,
  }) async {
    var dio = Dio();
    try {
      final nameParts = userName?.trim().split(RegExp(r'\s+'));

      Map<String, dynamic> body = {
        "userEmail": userEmail?.trim(),
        "userFirstName": nameParts?[0].trim(),
        "userLastName": nameParts?[1].trim(),
        "userNumber": userPhoneNumber,
      };

      var headers = {'Content-Type': 'application/json'};

      final response = await dio.request(
        'https://mafu-back.vercel.app/users/forgot-password',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UserModel.fromJson(data);
      }
      log(">>>>>>>>>>>>>>>>>>>>${response.statusMessage}");
      log(">>>>>>>>>>>>>>>>>>>>${response.statusCode}");

      throw const ServerException(message: 'Error server');
    } on DioException catch (e) {
      log('Exception: $e');
      throw const ServerException(
          message:
              'Une erreur est survenue lors de la mise a jour des infos de l\'utilisateur !!!');
    }
  }
}
