import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/core/common/models/user_model.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';
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

  Future<bool> checkNumber({required String userNumber});
  Future<UserModel> modifyPassword({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  });

  // firebase auth otp

  Future<void> sendOtpCode(
    String userPhoneNumber, {
    required Function(PhoneAuthCredential credential) completedVerification,
    required Function(FirebaseAuthException e) failedVerification,
    required Function(String verificationId, int? resendToken) onCodeSend,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  });

  Future<bool> verifyOtpCode(String verificationId, String smsCode);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient client;
  final FirebaseAuth _auth;

  AuthRemoteDataSourceImpl({
    required this.client,
    required FirebaseAuth auth,
  }) : _auth = auth;

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

        throw const ServerException(message: 'User Already Exists');
      }
    } on DioException catch (e) {
      debugPrint('Exception: $e');
      throw const ServerException(message: 'Cet utilisateur existe déjà!');
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

  @override
  Future<bool> checkNumber({required String userNumber}) async {
    try {
      final body = json.encode({
        "userNumber": userNumber,
      });

      final headers = {'Content-Type': 'application/json'};

      final response = await client.post(
        '${Endpoints.apiBaseUrl}/users/verify/number',
        data: body,
        options: Options(method: 'POST', headers: headers),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Failed to verify userNumber, cause is dont exist in our database');
      }
    } on Exception catch (e) {
      debugPrint('Exception: $e');
      throw const ServerException(
        message:
            "Échec de la vérification du numéro d'utilisateur, car il n'existe pas dans notre base de données",
      );
    }
  }

  @override
  Future<void> sendOtpCode(
    String userPhoneNumber, {
    required Function(PhoneAuthCredential credential) completedVerification,
    required Function(FirebaseAuthException e) failedVerification,
    required Function(String verificationId, int? resendToken) onCodeSend,
    required Function(String verificationId) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: userPhoneNumber,
      timeout: const Duration(seconds: 40),
      verificationCompleted: completedVerification,
      verificationFailed: failedVerification,
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<bool> verifyOtpCode(String verificationId, String smsCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);

      return true;
    } on ServerException catch (e) {
      debugPrint(e.message);
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<UserModel> modifyPassword({
    required String phoneNumber,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "userNumber": phoneNumber,
        "userNewPassword": password,
        "userNewPasswordC": confirmPassword
      });
      var dio = Dio();
      var response = await dio.request(
        'https://mafu-back.vercel.app/users/forgot-password',
        options: Options(
          method: 'PUT',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        debugPrint("::::::::::::::::::::${json.encode(response.data['data'])}");
        final data = response.data['data'];
        return UserModel.fromJson(data);
      } else {
        debugPrint("Failed to modify user password: ${response.statusMessage}");
        throw ServerException(
          message:
              'Failed to modify user password. Status: ${response.statusCode} - ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      debugPrint("DioException occurred: ${e.message}");
      debugPrint('DioException occurred: ${e.response?.data}');
      debugPrint('Status code: ${e.response?.statusCode}');
      debugPrint('Headers: ${e.response?.headers}');
      debugPrint('Request data: ${e.requestOptions.data}');
      throw ServerException(message: e.toString());
    } catch (e) {
      debugPrint("An error occurred: $e");
      throw ServerException(message: e.toString());
    }
  }
}
