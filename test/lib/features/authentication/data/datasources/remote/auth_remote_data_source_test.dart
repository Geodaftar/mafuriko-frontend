import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mafuriko/core/common/data_local/auth_local_data_source.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/core/common/models/user_model.dart';
import 'package:mafuriko/features/authentication/data/datasources/remote/auth_remote_data_source.dart';
import 'package:mafuriko/shared/errors/exceptions.dart';
import 'package:mafuriko/shared/errors/failures.dart';
import 'package:mafuriko/shared/helpers/network_info.dart';
import 'package:mocktail/mocktail.dart';

// import 'package:mafuriko/core/error/exceptions.dart';
// import 'package:mafuriko/features/authentication/data/models/user_model.dart';
import 'package:mafuriko/features/authentication/data/repositories/auth_repository_impl.dart';

class MockDio extends Mock implements Dio {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late MockDio mockDio;
  final MockAuthLocalDataSource mockAuthLocalDataSource =
      MockAuthLocalDataSource();
  final MockAuthRemoteDataSource mockAuthRemoteDataSource =
      MockAuthRemoteDataSource();
  final MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  late AuthRepositoryImpl authRepository;
  MockUserModel mockUserModel = MockUserModel();

  setUp(() {
    mockDio = MockDio();
    authRepository = AuthRepositoryImpl(
        dataSource: mockAuthRemoteDataSource,
        localDataSource: mockAuthLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  const String baseUrl = 'https://api.example.com/users/signup';
  const Map<String, dynamic> mockBody = {
    "userEmail": "test@example.com",
    "userNumber": "1234567890",
    "userPassword": "password123",
    "userPasswordC": "password123",
  };

  const Map<String, dynamic> mockResponse = {
    "id": "123",
    "userEmail": "test@example.com",
    "userName": "Test User",
    "userNumber": "1234567890",
  };

  group('signUp', () {
    when(() => mockAuthRemoteDataSource.signUp(
          userEmail: any(named: 'userEmail'),
          userNumber: any(named: 'userNumber'),
          userPassword: any(named: 'userPassword'),
          confirmPassword: any(named: 'confirmPassword'),
        )).thenAnswer(
      (_) async => UserModel(
        id: '123',
        userEmail: 'test@example.com',
        userName: 'Test User',
        userNumber: '1234567890',
      ),
    );

    when(() => mockAuthLocalDataSource.cacheUser(any()))
        .thenAnswer((_) async => Future.value());
    when(() => mockAuthLocalDataSource.cacheToken(any()))
        .thenAnswer((_) async => Future.value());
    test('should return UserModel when the API call is successful', () async {
      // Arrange
      when(() => mockDio.post(
            baseUrl,
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: baseUrl),
        ),
      );

      // Act
      final result = await authRepository.signUp(
        userEmail: 'test@example.com',
        userNumber: '1234567890',
        userPassword: 'password123',
        confirmPassword: 'password123',
      );

      // Assert
      expect(result, isA<Right<Failure, UserEntity>>());
      expect(
          result.getOrElse(() {
            return UserEntity();
          }).userEmail,
          'test@example.com');
      expect(
          result.getOrElse(() {
            return UserEntity();
          }).userName,
          'Test User');
    });

    test('should throw ServerException when the API returns an error',
        () async {
      // Arrange
      when(() => mockAuthRemoteDataSource.signUp(
            userEmail: any(named: 'userEmail'),
            userNumber: any(named: 'userNumber'),
            userPassword: any(named: 'userPassword'),
            confirmPassword: any(named: 'confirmPassword'),
          )).thenThrow(ServerException(message: 'User Already Exists'));

      // Act & Assert
      // Act
      final result = await authRepository.signUp(
        userEmail: 'test@example.com',
        userNumber: '1234567890',
        userPassword: 'password123',
        confirmPassword: 'password123',
      );

      // Assert
      expect(result, isA<Left<Failure, UserEntity>>());
    });

    test('should throw ServerException when DioException has no response',
        () async {
      // Arrange
      when(() => mockDio.post(
            baseUrl,
            data: any(named: 'data'),
            options: any(named: 'options'),
          )).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: baseUrl),
        ),
      );

      // Act & Assert
      final result = await authRepository.signUp(
        userEmail: 'test@example.com',
        userNumber: '1234567890',
        userPassword: 'password123',
        confirmPassword: 'password123',
      );

      // Assert
      expect(result, isA<Left<Failure, UserEntity>>());
    });
  });

  group("Login", () {
    test('should return UserEntity when login is successful', () async {
      final mockUsrModel = UserModel(
        id: '123',
        userEmail: 'test@example.com',
        token: 'sample-token',
        // Ajoutez d'autres propriétés si nécessaires
      );
      // Arrange
      when(() => mockAuthRemoteDataSource.login(
            userEmail: any(named: 'userEmail'),
            userPassword: any(named: 'userPassword'),
          )).thenAnswer((_) async => mockUsrModel);

      when(() => mockAuthLocalDataSource.cacheUser(mockUsrModel))
          .thenAnswer((_) async => Future.value());
      when(() => mockAuthLocalDataSource.cacheToken(mockUsrModel.token))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await authRepository.login(
        userEmail: 'test@example.com',
        userPassword: 'password123',
      );

      // Assert
      expect(result,
          isA<Right>()); // Vérifie que le résultat est un succès (Right)
      final user = result.getOrElse(() => UserEntity());
      expect(user.userEmail,
          'test@example.com'); // Vérifie l'email de l'utilisateur

      verify(() => mockAuthRemoteDataSource.login(
                userEmail: 'test@example.com',
                userPassword: 'password123',
              ))
          .called(1); // Vérifie que le mock est appelé avec les bons arguments
      verify(() => mockAuthLocalDataSource.cacheUser(mockUsrModel)).called(1);
      verify(() => mockAuthLocalDataSource.cacheToken(mockUsrModel.token))
          .called(1);
    });

    test('should return ServerFailure when login fails', () async {
      final mockUsrModel = UserModel(
        id: '123',
        userEmail: 'test@example.com',
        token: 'sample-token',
        // Ajoutez d'autres propriétés si nécessaires
      );
      // Arrange
      when(() => mockAuthRemoteDataSource.login(
            userEmail: any(named: 'userEmail'),
            userPassword: any(named: 'userPassword'),
          )).thenThrow(ServerException(message: 'Invalid credentials'));

      when(() => mockAuthLocalDataSource.cacheUser(any()))
          .thenAnswer((_) async {});
      when(() => mockAuthLocalDataSource.cacheToken(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await authRepository.login(
        userEmail: 'wrong@example.com',
        userPassword: 'wrongpassword',
      );

      // Assert
      expect(
          result, isA<Left>()); // Vérifie que le résultat est un échec (Left)
      result.fold(
        (failure) => expect(failure.message,
            'Invalid credentials'), // Vérifie le message d'erreur
        (_) => fail('Expected a failure but got a success'),
      );

      verify(() => mockAuthRemoteDataSource.login(
                userEmail: 'wrong@example.com',
                userPassword: 'wrongpassword',
              ))
          .called(
              1); // Vérifie que le mock est appelé avec les mauvais arguments
      verifyNever(() => mockAuthLocalDataSource.cacheToken('sample-token'))
          .called(0);

      verifyNever(() => mockAuthLocalDataSource.cacheUser(mockUsrModel))
          .called(0);
      ;
    });
  });
}
