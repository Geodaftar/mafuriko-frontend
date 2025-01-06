import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';

class NavigationCubit extends Cubit<int> {
  final GoRouter _router;
  NavigationCubit(
    this._router,
  ) : super(0);
  void updateIndex(int index) {
    emit(index);
    switch (index) {
      case 0:
        _router.pushNamed(Paths.home); // Naviguer vers 'home'
        break;
      case 1:
        _router.pushNamed(Paths.mapScreen); // Naviguer vers 'map'
        break;
      case 2:
        _router.pushNamed(Paths.send); // Naviguer vers 'send'
        break;
    }
  }
}
