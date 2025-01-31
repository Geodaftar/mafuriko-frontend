import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mafuriko/features/maps/data/services/geolocator_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:geolocator/geolocator.dart';

// Mock de Geolocator
// Mock de GeolocatorPlatform
class MockGeolocatorPlatform extends Mock implements GeolocatorPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GeolocatorService geolocatorService;
  late MockGeolocatorPlatform mockGeolocatorPlatform;

  const MethodChannel locationChannel =
      MethodChannel('flutter.baseflow.com/geolocator');

  setUp(() {
    mockGeolocatorPlatform = MockGeolocatorPlatform();
    geolocatorService = GeolocatorService();

    // Remplace la plateforme de Geolocator par notre mock
    // GeolocatorPlatform.instance = mockGeolocatorPlatform;
  });

  final testPosition = Position(
    latitude: 10.0,
    longitude: 20.0,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    altitudeAccuracy: 20,
    headingAccuracy: 20,
    speedAccuracy: 0.0,
  );

  Future locationHandler(MethodCall methodCall) async {
    //whenever `getCurrentPosition` method is called we want to return a testPosition
    if (methodCall.method == 'getCurrentPosition') {
      return testPosition.toJson();
    }
    // this is the check that's supposed to happend
    // on the Device before you try to get user's
    //location, so I set it to true
    if (methodCall.method == 'isLocationServiceEnabled') {
      return true;
    }
    //Here's another check that's happens on the user's device, we defaulted
    //it to authorized, and this is simulating when the user grants
    //access to their location
    if (methodCall.method == 'checkPermission') {
      return 3;
    }
  }

  group('GeolocatorService', () {
    // test('should throw exception when location services are disabled',
    //     () async {
    //   // Arrange
    //   when(() => mockGeolocatorPlatform.isLocationServiceEnabled())
    //       .thenAnswer((_) async => false);

    //   // Act & Assert
    //   expect(
    //     () async => await geolocatorService.getCurrentPosition(),
    //     throwsException,
    //   );
    // });

    // test('should throw exception when location permission is denied', () async {
    //   // Arrange
    //   when(() => mockGeolocatorPlatform.isLocationServiceEnabled())
    //       .thenAnswer((_) async => true);
    //   when(() => mockGeolocatorPlatform.checkPermission())
    //       .thenAnswer((_) async => LocationPermission.denied);

    //   when(() => mockGeolocatorPlatform.requestPermission())
    //       .thenAnswer((_) async => LocationPermission.denied);

    //   // Act & Assert
    //   expect(
    //     () async => await geolocatorService.getCurrentPosition(),
    //     throwsException,
    //   );
    // });

    // test('should throw exception when location permission is denied forever',
    //     () async {
    //   // Arrange
    //   when(() => mockGeolocatorPlatform.isLocationServiceEnabled())
    //       .thenAnswer((_) async => true);
    //   when(() => mockGeolocatorPlatform.checkPermission())
    //       .thenAnswer((_) async => LocationPermission.deniedForever);

    //   // Act & Assert
    //   expect(
    //     () async => await geolocatorService.getCurrentPosition(),
    //     throwsException,
    //   );
    // });

    setUpAll(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(locationChannel, locationHandler);
    });
    test(
        'should return position when location is available and permission is granted',
        () async {
      // Arrange
      when(() => mockGeolocatorPlatform.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(() => mockGeolocatorPlatform.checkPermission())
          .thenAnswer((_) async => LocationPermission.whileInUse);
      when(() => mockGeolocatorPlatform.getCurrentPosition())
          .thenAnswer((_) async => Position(
                latitude: 10.0,
                longitude: 20.0,
                timestamp: DateTime.now(),
                accuracy: 0.0,
                altitude: 0.0,
                heading: 0.0,
                speed: 0.0,
                altitudeAccuracy: 20,
                headingAccuracy: 20,
                speedAccuracy: 0.0,
              ));

      // Act
      final result = await geolocatorService.getCurrentPosition();

      // Assert
      expect(result.latitude, 10.0);
      expect(result.longitude, 20.0);
    });
  });
}
