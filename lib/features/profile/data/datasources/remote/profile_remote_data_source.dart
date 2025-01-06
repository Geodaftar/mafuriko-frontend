import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/core/common/data_local/auth_local_data_source.dart';
import 'package:mafuriko/core/common/models/user_model.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/helpers/upload_s3_image.dart';
import 'package:nb_utils/nb_utils.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> updateUser({
    String? fullName,
    String? userEmail,
    String? userPhoneNumber,
  });

  Future<bool> updatePassword(
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword});

  Future<UserModel> updateProfileImage(
    XFile? image,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final HttpClient client;
  const ProfileRemoteDataSourceImpl(
    this.client,
  );

  @override
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    //get user token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${sharedPreferences.get(token)}"
      };
      var data = json.encode({
        "userPassword": currentPassword,
        "userNewPassword": newPassword,
        "userNewPasswordC": confirmPassword,
      });

      final response = await client.put(
        'https://mafu-back.vercel.app/users/update-password',
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
      throw ServerException(
        message: e.response?.data['message'] ?? e.type.name,
      );
    }
  }

  @override
  Future<UserModel> updateUser({
    String? fullName,
    String? userEmail,
    String? userPhoneNumber,
  }) async {
    try {
      // final nameParts = userName?.trim().split(RegExp(r'\s+'));
      //get user token
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, dynamic> body = {
        // "userEmail": userEmail?.trim(),
        "userFullName": fullName,
        // "userLastName": nameParts?[1].trim(),
        "userNumber": userPhoneNumber,
      };

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${sharedPreferences.get(token)}"
      };

      final response = await client.put(
        'https://mafu-back.vercel.app/users/update',
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
      throw ServerException(
        message: e.response?.data['message'] ?? e.type.name,
      );
    }
  }

  @override
  Future<UserModel> updateProfileImage(XFile? image) async {
    log("imageUri: ${image?.path ?? "empty"}");
    try {
      Uri? userImageUri;
      if (image != null) {
        userImageUri = await uploadFile(File(image.path), "user");
        log('avatar image take by user  ${userImageUri?.toString()}');
      }
      //get user token
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${sharedPreferences.get(token)}"
      };
      Map<String, dynamic> body = {
        "image": userImageUri.toString(),
      };

      if (userImageUri != null) {
        final response = await client.put(
          'https://mafu-back.vercel.app/users/update',
          options: Options(
            method: 'PUT',
            headers: headers,
          ),
          data: body,
        );

        log("status: ${response.statusCode}");
        log("statusMessage: ${response.statusMessage}");
        log("data: ${response.data}");
        if (response.statusCode == 200) {
          final data = response.data['data'];
          return UserModel.fromJson(data);
        }
      }
      throw const ServerException(message: 'Image not found');
    } on DioException catch (e) {
      log('Exception: $e');
      throw ServerException(
        message: e.response?.data['message'] ?? e.type.name,
      );
    }
  }
}
