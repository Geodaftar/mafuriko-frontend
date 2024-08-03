import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafuriko/features/mafuriko_app.dart';
import 'firebase_options.dart';
import 'service_locator.dart' as sl;
import 'shared/helpers/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await sl.init();
  Bloc.observer = const AppBlocObserver();

  runApp(const MafurikoApp());
}
