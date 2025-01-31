import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:mafuriko/features/onboarding/cubit/count_cubit.dart';
import 'package:mafuriko/firebase_options.dart';
import 'package:mafuriko/shared/theme/ziva_theme.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mafuriko/features/onboarding/cubit/count_cubit.dart';
import 'package:mafuriko/features/onboarding/screens/onboarding_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/service_locator.dart' as sl;

class MockCountCubit extends MockCubit<CountState> implements CountCubit {}

class MockCountState extends Fake implements CountState {}

class MockToggleCubit extends MockCubit<bool> implements ToggleCubit {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthState extends Fake implements AuthState {}

void main() {
  late MockCountCubit mockCountCubit;
  late MockToggleCubit mockToggleCubit;
  late MockAuthBloc mockAuthBloc;

  setUpAll(() async {
    registerFallbackValue(MockCountState());
    // TestWidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();
    // await sl.init();
  });

  setUp(() {
    mockCountCubit = MockCountCubit();
    when(() => mockCountCubit.state).thenReturn(CountInitial());

    mockToggleCubit = MockToggleCubit();
    when(() => mockToggleCubit.state).thenReturn(false);
  });

  Widget createTestableWidget(Widget child) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/${Paths.signUp}',
          name: Paths.signUp,
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    );

    return ScreenUtilInit(
      designSize: const Size(890, 1244),
      builder: (context, _) => MultiBlocProvider(
        providers: [
          BlocProvider<CountCubit>.value(value: mockCountCubit),
          BlocProvider<ToggleCubit>.value(value: mockToggleCubit),
          // BlocProvider(
          //   create: (_) => sl.sl<AuthBloc>()..add(CheckAuthEvent()),
          // ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          theme: AppTheme.theme,
          builder: (context, child) => child!,
        ),
      ),
    );
  }

  testWidgets(
    "Vérifie le comportement de l'écran d'onboarding",
    (WidgetTester tester) async {
      // Simuler les changements d'état du Cubit
      whenListen(
        mockCountCubit,
        Stream.fromIterable([
          CountInitial(),
          const UpdatePosition(pagePos: 0),
          const UpdatePosition(pagePos: 1),
          const UpdatePosition(pagePos: 2),
        ]),
      );

      // Charger le widget
      await tester.pumpWidget(createTestableWidget(const OnboardingView()));

      // Vérifie que le texte "Sauter" est visible au début
      expect(find.text("Sauter"), findsOneWidget);

      // Swipe vers la page suivante
      await tester.fling(find.byType(PageView), const Offset(-500, 0), 1000);
      await tester.pumpAndSettle();

      // Vérifie la mise à jour de l'état
      verify(() => mockCountCubit.positionChanged(1)).called(1);

      // Swipe vers la dernière page
      await tester.fling(find.byType(PageView), const Offset(-500, 0), 1000);
      await tester.pumpAndSettle();

      verify(() => mockCountCubit.positionChanged(2)).called(1);

      // Vérifie que "Sauter" n'est plus visible
      expect(find.text("Sauter"), findsNothing);

      // Vérifie la présence du bouton "Commencer"
      expect(find.text("Commencer"), findsOneWidget);

      // Simule un clic sur "Commencer"
      // await tester.tap(find.text("Commencer"));
      // await tester.pumpAndSettle();

      // // Vérifie que l'utilisateur est redirigé vers la page de signup
      // expect(find.text("Créez votre compte"), findsOneWidget);
    },
  );
}
