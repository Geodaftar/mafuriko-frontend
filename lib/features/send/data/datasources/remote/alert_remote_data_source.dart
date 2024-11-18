import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/features/send/data/models/alert_model.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';
import 'package:mafuriko/shared/helpers/upload_s3_image.dart';

abstract interface class AlertRemoteDataSource {
  Future<AlertModel?> postAlert({
    required String uid,
    String? description,
    required LatLng position,
    required String location,
    required String intensity,
    required String category,
    required String temp,
    required String weather,
    XFile? image,
  });

  Future<List<AlertModel>> fetchAlerts();
}

class AlertRemoteDataSourceImpl implements AlertRemoteDataSource {
  final HttpClient client;
  const AlertRemoteDataSourceImpl(this.client);
  @override
  Future<AlertModel?> postAlert({
    required String uid,
    String? description,
    required LatLng position,
    required String location,
    required String intensity,
    required String category,
    required String temp,
    required String weather,
    XFile? image,
  }) async {
    try {
      Uri? floodImageUri;
      if (image != null) {
        floodImageUri = await uploadFile(File(image.path), "alerts");
        log('flood image take by user  $floodImageUri');
      }

      final headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        'userId': uid,
        'floodScene': location,
        'longitude': '${position.longitude}',
        'latitude': '${position.latitude}',
        'floodDescription': description,
        'floodIntensity': intensity,
        'floodImage': '$floodImageUri',
        'floodCategory': category,
        'temperature': temp,
        'weather': weather,
      };
      final response = await client.post(
        'https://mafu-back.vercel.app/zones-inondees/add',
        data: jsonEncode(body),
        options: Options(method: 'POST', headers: headers),
      );

      if (response.statusCode == 201) {
        final data = response.data;

        log('post request data ::::::::::::::::::::::::::::\n $data \n:::::::::::::::::::::::::::::');

        return AlertModel.fromJson(data['data']);
      }
      return null;
    } on ServerException catch (e) {
      log('alert posting response failure message :::::::::::${e.message}');
      log('alert posting response failure status code :::::::::::${e.statusCode}');
      log('alert posting response failure code :::::::::::${e.code}');
      throw ServerFailure(message: e.message);
    }
  }

  @override
  Future<List<AlertModel>> fetchAlerts() async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final response = await client.get(
          'https://mafu-back.vercel.app/zones-inondees/all-infos',
          options: Options(
            headers: headers,
            method: 'GET',
          ));

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data is List) {
          // If the response is a List of alerts
          return data.map((json) => AlertModel.fromJson(json)).toList();
        } else if (data is Map) {
          // If the response is a Map, extract the list from the map
          final alerts = data['data'];
          if (alerts is List) {
            return alerts.map((json) => AlertModel.fromJson(json)).toList();
          }
          log('No alerts found');
        }
      }
      return [];
    } on DioException catch (e) {
      log('alert fetching response failure message :::::::::::${e.message}');
      // log('alert fetching response failure status code :::::::::::${e.statusCode}');
      // log('alert fetching response failure code :::::::::::${e.code}');
      throw ServerException(
          message: '${e.response?.data['message'] ?? e.type.name}');
    }
  }
}
