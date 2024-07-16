import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mafuriko/features/authentication/data/models/user_model.dart';
import 'package:mafuriko/shared/helpers/endpoints.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel?> signUp(
      {required String userEmail,
      required String userName,
      required String userNumber,
      required String userPassword,
      required String confirmPassword});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel?> signUp(
      {required String userEmail,
      required String userName,
      required String userNumber,
      required String userPassword,
      required String confirmPassword}) async {
    Map<String, dynamic> body = {};
    final headers = {'Content-Type': 'application/json'};

    final response = await client.request(
      '${Endpoints.apiBaseUrl}/users/signup',
      data: jsonEncode(body),
      options: Options(method: 'POST', headers: headers),
    );
    if (response.statusCode == 200) {
      debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }

    return null;
  }
}
