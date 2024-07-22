import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/features/authentication/data/models/user_model.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/helpers/endpoints.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUp({
    required String userEmail,
    required String userName,
    required String userNumber,
    required String userPassword,
    required String confirmPassword,
  });

  Future<UserModel> login({
    required String userEmail,
    required String userPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signUp(
      {required String userEmail,
      required String userName,
      required String userNumber,
      required String userPassword,
      required String confirmPassword}) async {
    try {
      final nameParts = userName.trim().split(RegExp(r'\s+'));

      Map<String, dynamic> body = {
        "userEmail": userEmail.trim(),
        "userFirstName": nameParts[0].trim(),
        "userLastName": nameParts[1].trim(),
        "userNumber": userNumber.trim(),
        "userPassword": userPassword.trim(),
        "userPasswordC": confirmPassword.trim(),
      };
      final headers = {'Content-Type': 'application/json'};

      final response = await client.post(
        '${Endpoints.apiBaseUrl}/users/signup',
        data: jsonEncode(body),
        options: Options(method: 'POST', headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("::::::::::::::::::::${json.encode(response.data['data'])}");
        final data = response.data['data'];
        return UserModel.fromJson(data);
      } else {
        debugPrint(">>>>>>>>>>>>>>>>>>>>${response.statusMessage}");
        debugPrint(">>>>>>>>>>>>>>>>>>>>${response.statusCode}");

        throw Exception('Failed to sign up');
      }
    } on Exception catch (e) {
      debugPrint('Exception: $e');
      throw const ServerException(message: 'An error occurred during sign up');
    }
  }

  @override
  Future<UserModel> login(
      {required String userEmail, required String userPassword}) async {
    try {
      final headers = {'Content-Type': 'application/json'};

      Map<String, dynamic> body = {
        "userEmail": userEmail.trim(),
        "userPassword": userPassword.trim(),
      };

      final response = await client.post(
        '${Endpoints.apiBaseUrl}/users/signin',
        data: jsonEncode(body),
        options: Options(method: 'POST', headers: headers),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("::::::::::::::::::::${json.encode(response.data['data'])}");
        final data = response.data['data'];
        return UserModel.fromJson(data);
      } else {
        debugPrint(">>>>>>>>>>>>>>>>>>>>${response.statusMessage}");
        debugPrint(">>>>>>>>>>>>>>>>>>>>${response.statusCode}");

        throw Exception('Failed to sign up');
      }
    } catch (e) {
      debugPrint('Exception::::::: $e');
      throw const ServerException(message: 'An error occurred during sign in');
    }
  }
}
