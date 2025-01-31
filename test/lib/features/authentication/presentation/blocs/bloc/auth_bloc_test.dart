import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mafuriko/core/common/entities/user_entity.dart';
import 'package:mafuriko/features/authentication/domain/repositories/auth_repository.dart';
import 'package:mafuriko/features/authentication/domain/usecases/check_number_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/get_cache.dart';
import 'package:mafuriko/features/authentication/domain/usecases/login_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/modify_pass_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/send_opt_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:mafuriko/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nb_utils/nb_utils.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthState extends Fake implements AuthState {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockGetCachedUser extends Mock implements GetCachedUser {}

class MockCheckNumberUseCase extends Mock implements CheckNumberUseCase {}

class MockSendOtpCodeUseCase extends Mock implements SendOtpCodeUseCase {}

class MockVerifyOtpCode extends Mock implements VerifyOtpCode {}

class MockModifyPassUseCase extends Mock implements ModifyPassUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

class MockDio extends Mock implements Dio {}

final mockDio = MockDio();

void main() {
  late AuthBloc authBloc;
  final mockPrefs = MockSharedPreferences();
  final mockAuthRepository = MockAuthRepository();
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLoginUseCase mockLoginUseCase;
  late MockGetCachedUser mockGetCachedUser;
  late MockCheckNumberUseCase mockCheckNumberUseCase;
  late MockSendOtpCodeUseCase mockSendOtpCodeUseCase;
  late MockVerifyOtpCode mockVerifyOtpCode;
  late MockModifyPassUseCase mockModifyPassUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  final mockFirebaseApp = MockFirebaseApp();

  setUpAll(() async {
    registerFallbackValue(MockAuthState());
    TestWidgetsFlutterBinding.ensureInitialized();
    // Mock Firebase initialization
    // when(() => Firebase.initializeApp())
    //     .thenAnswer((_) async => mockFirebaseApp);

    // await sl.init();
  });

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    mockLoginUseCase = MockLoginUseCase();

    mockGetCachedUser = MockGetCachedUser();
    mockCheckNumberUseCase = MockCheckNumberUseCase();
    mockSendOtpCodeUseCase = MockSendOtpCodeUseCase();
    mockVerifyOtpCode = MockVerifyOtpCode();
    mockModifyPassUseCase = MockModifyPassUseCase();
    mockLogoutUseCase = MockLogoutUseCase();

    // when(() => mockPrefs.getString(any())).thenReturn(null);
    // when(() => mockAuthBloc.state).thenReturn(AuthInitial());
    // when(() => mockSignUpUseCase.repository).thenReturn(mockAuthRepository);

    authBloc = AuthBloc(
      signUpUseCase: mockSignUpUseCase,
      loginUseCase: mockLoginUseCase,
      getCachedUser: mockGetCachedUser,
      checkNumberUseCase: mockCheckNumberUseCase,
      sendOtpCodeUseCase: mockSendOtpCodeUseCase,
      verifyOtpCode: mockVerifyOtpCode,
      modifyPassUseCase: mockModifyPassUseCase,
      logoutUseCase: mockLogoutUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });
  test('should return UserModel on successful signup', () async {
    final responsePayload = {
      'id': '123',
      'userEmail': 'test@example.com',
      'userNumber': '1234567890',
      'userName': 'Test User',
    };

    // Simulez une réponse 201
    when(() => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        )).thenAnswer((_) async => Response(
          data: responsePayload,
          statusCode: 201,
          requestOptions: RequestOptions(path: ''),
        ));

    // final result = await SignUpRepository(dio: mockDio).signUp(
    //   userEmail: 'test@example.com',
    //   userNumber: '1234567890',
    //   userPassword: 'password123',
    //   confirmPassword: 'password123',
    // );

    // expect(result, isA<UserModel>());
    // expect(result.userEmail, equals('test@example.com'));
  });

  // group("Test sign In process", () {
  //   UserEntity user = UserEntity(
  //       userName: "john Doe",
  //       userEmail: "johndoe@gmail.com",
  //       userNumber: "+229079990000",
  //       userPassword: "password123",
  //       confirmPassword: "password123");
  //   blocTest(
  //     'emits [AuthLoading, AuthSuccess] when SignUpRequested succeeds',
  //     build: () {
  //       when(() => mockSignUpUseCase.call(SignUpParams(
  //             email: user.userEmail ?? 'test@example.com',
  //             password: user.userPassword ?? 'password123',
  //             confirmPassword: user.confirmPassword ?? 'password123',
  //             phoneNumber: user.userNumber ?? '1234567890',
  //           ))).thenAnswer((_) async => Right(user));
  //       return authBloc;
  //     },
  //     act: (bloc) => bloc.add(SignUpRequested(
  //       userName: user.userName ?? 'Jonh doe',
  //       userEmail: user.userEmail ?? 'test@example.com',
  //       userPassword: user.userPassword ?? 'password123',
  //       confirmPassword: user.confirmPassword ?? 'password123',
  //       userNumber: user.userNumber ?? '1234567890',
  //     )),
  //     expect: () => [
  //       AuthLoading(),
  //       AuthSuccess(user: user, request: Request.signup),
  //     ],
  //   );
  // });
}
