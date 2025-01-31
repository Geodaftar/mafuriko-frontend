import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';

import 'package:mafuriko/shared/helpers/validators.dart';

import 'package:mocktail/mocktail.dart';

class MockToggleCubit extends MockCubit<bool> implements ToggleCubit {}

void main() {
  late MockToggleCubit mockToggleCubit;

  // String? verifiyConfMdp(
  //     String password, String cfPassword, PasswordError? error) {
  //   if (error?.name == null && password != cfPassword) {
  //     return ' *les deux mot de passe doivent être identique!';
  //   } else {
  //     return error?.name;
  //   }
  // }

  // setUpAll(() {
  //   registerFallbackValue(MockCountState());
  // });
  setUpAll(() async {
    // registerFallbackValue(MockAuthState());
    TestWidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    // await sl.init();
  });

  setUp(() {
    mockToggleCubit = MockToggleCubit();
    when(() => mockToggleCubit.state).thenReturn(false);
  });

  String emailValue = '';
  String telephoneValue = '';
  String passwordValue = '';
  String cfPasswordValue = '';
  PasswordError? pwdError;
  group('Test Input validator', () {
    test('Validation d\'un email vide', () {
      final email = Email.dirty(emailValue);
      expect(email.validator(email.value)?.name, '* Email est requis');
    });

    test('Validation d\'un email invalide', () {
      emailValue = "invalide";
      final email = Email.dirty(emailValue);
      expect(email.validator(email.value)?.name,
          '* Ceci n\'est pas un email valide');
    });
    test('Validation d\'un email valide', () {
      emailValue = "test@gmail.com";
      final email = Email.dirty(emailValue);
      expect(email.validator(email.value)?.name, null);
    });

    test('Validation d\'un mot de passe ', () {
      passwordValue = "password1123";
      final password = PasswordValidator.dirty(passwordValue);
      expect(password.validator(password.value)?.name, null);
    });
    test('Validation d\'un mot de passe vide', () {
      final password = PasswordValidator.dirty(passwordValue);
      expect(password.validator(password.value)?.name,
          "* le mot de passe est requis");
    });
    test('Validation d\'un mot de passe invalide (moins de 6 chars)', () {
      passwordValue = "pass";
      final password = PasswordValidator.dirty(passwordValue);
      expect(
          password.validator(password.value)?.name, "* Mot de passe invalide");
    });
  });

  // group('Test Form Widget ', () {
  //   emailValue = 'test@example.com';
  //   telephoneValue = '0700000000';
  //   passwordValue = 'password123';
  //   cfPasswordValue = 'password123';

  //   testWidgets(
  //     "Vérifie le comportement de l'écran d'inscription",
  //     (WidgetTester tester) async {
  //       // Simuler les changements d'état du Cubit
  //       whenListen(
  //         mockToggleCubit,
  //         Stream.fromIterable([false, true]),
  //       );

  //       whenListen(
  //           mockAuthBloc,
  //           Stream.fromIterable([
  //             AuthUnauthenticated(),
  //             AuthInitial(),
  //             AuthFailure(message: "Erreur test login"),
  //             AuthSuccess(
  //                 user: UserEntity(
  //                     userEmail: emailValue,
  //                     userNumber: telephoneValue,
  //                     userPassword: passwordValue,
  //                     confirmPassword: cfPasswordValue))
  //           ]),
  //           initialState: AuthUnauthenticated());

  //       // Charger le widget
  //       await tester.pumpWidget(createTestableWidget(const SignUpScreen()));

  //       // Vérifie que le texte "Sauter" est visible au début
  //       expect(find.text("Créez votre compte"), findsOneWidget);

  //       //vérifier que le bouton continuer n'envoie pas un formulaire vide
  //       // Vérifiez si les champs sont affichés
  //       expect(find.text('Email'), findsOneWidget);
  //       expect(find.text('Téléphone'), findsOneWidget);
  //       expect(find.text('Mot de passe'), findsOneWidget);
  //       expect(find.text('Confirmer le mot de passe'), findsOneWidget);

  //       // Remplissez les champs
  //       await tester.enterText(find.byType(TextFormField).at(0), emailValue);
  //       await tester.enterText(
  //           find.byType(TextFormField).at(1), telephoneValue);
  //       await tester.enterText(find.byType(TextFormField).at(2), passwordValue);
  //       await tester.enterText(
  //           find.byType(TextFormField).at(3), cfPasswordValue);

  //       // Soumettez le formulaire
  //       await tester.tap(find.text('Continuer'));
  //       await tester.pump();

  //       expect(find.text("Inscription réussie"), findsOneWidget);
  //     },
  //   );
  // });
}
