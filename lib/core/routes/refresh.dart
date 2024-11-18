import 'package:flutter/material.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';

class GoRouterRefreshBloc extends ChangeNotifier {
  final AuthBloc authBloc;

  GoRouterRefreshBloc(this.authBloc) {
    // Écoute les changements d'état dans AuthBloc et notifie les listeners
    authBloc.stream.listen((_) {
      notifyListeners();
    });
  }
}
