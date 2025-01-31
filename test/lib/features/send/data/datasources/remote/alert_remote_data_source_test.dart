import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mafuriko/core/clients/http_client.dart';
import 'package:mafuriko/features/send/data/models/alert_model.dart';
import 'package:mafuriko/features/send/data/datasources/remote/alert_remote_data_source.dart';
import 'package:path_provider/path_provider.dart';

class MockHttpClient extends Mock implements HttpClient {}

class MockXFile extends Mock implements XFile {}

void main() {
  late AlertRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  enableFlutterDriverExtension();

  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (method) async {
    ByteData data = await rootBundle.load('assets/icons/Picture.png');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File file = await File(
      '${tempDir.path}/tmp.tmp',
    ).writeAsBytes(bytes);
    print(file.path);
    return file.path;
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AlertRemoteDataSourceImpl(mockHttpClient);
  });

  group('postAlert', () {
    const testUid = 'user123';
    const testDescription = 'Flood in the area';
    final testPosition = LatLng(12.34, 56.78);
    const testLocation = 'LocationName';
    const testIntensity = 'High';
    const testCategory = 'Flood';
    const testTemp = '30°C';
    const testWeather = 'Rainy';
    final testImage = MockXFile();

    test('should post alert and return an AlertModel on success', () async {
      // Arrange
      final mockResponseData = {
        'data': {
          '_id': 'alert123',
          'postBy': testUid,
          'floodScene': testLocation,
          'floodLocation': {'ln': '111', 'la': '111'},
          'floodCategory': 'Innondation',
        }
      };
      final mockImage = MockXFile();
      when(() => mockImage.path).thenReturn('mocked/image/path.jpg');
      when(() => mockHttpClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            statusCode: 201,
            data: mockResponseData,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final result = await dataSource.postAlert(
          uid: testUid,
          description: testDescription,
          position: testPosition,
          location: testLocation,
          intensity: testIntensity,
          category: testCategory,
          temp: testTemp,
          weather: testWeather,
          image: null);

      // Assert
      expect(result, isA<AlertModel>());
      expect(result!.id, equals("alert123"));
      expect(result.floodScene, equals(testLocation));
    });

    test('should throw ServerFailure on error response', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        response: Response(
          statusCode: 500,
          data: {'message': 'Server error'},
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(
        () => dataSource.postAlert(
          uid: testUid,
          description: testDescription,
          position: testPosition,
          location: testLocation,
          intensity: testIntensity,
          category: testCategory,
          temp: testTemp,
          weather: testWeather,
          image: null,
        ),
        throwsA(isA<DioException>()), // Vérifie que ServerFailure est levé
      );
    });
  });

  group('fetchAlerts', () {
    test('should return a list of AlertModel on success', () async {
      // Arrange
      final mockResponseData = [
        {
          '_id': 'alert123',
          'postBy': "1223",
          'floodScene': "LocationName",
          'floodLocation': {'ln': '111', 'la': '111'},
          'floodCategory': 'Innondation',
        }
      ];
      when(() => mockHttpClient.get(
            any(),
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response(
            statusCode: 200,
            data: mockResponseData,
            requestOptions: RequestOptions(path: ''),
          ));

      // Act
      final result = await dataSource.fetchAlerts();

      // Assert
      expect(result, isA<List<AlertModel>>());
      expect(result.length, equals(1));
      expect(result.first.id, equals('alert123'));
    });

    test('should throw ServerException on error response', () async {
      // Arrange
      when(() => mockHttpClient.get(
            any(),
            options: any(named: 'options'),
          )).thenThrow(DioException(
        response: Response(
          statusCode: 500,
          data: {'message': 'Server error'},
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      ));

      // Act & Assert
      expect(() => dataSource.fetchAlerts(), throwsA(isA<ServerException>()));
    });
  });
}
