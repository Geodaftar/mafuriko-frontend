import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'count_state.dart';

class CountCubit extends Cubit<CountState> {
  CountCubit() : super(CountInitial());

  void positionChanged(int pos) {
    emit(UpdatePosition(pagePos: pos));
  }
}
