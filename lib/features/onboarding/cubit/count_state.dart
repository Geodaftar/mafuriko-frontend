part of 'count_cubit.dart';

sealed class CountState extends Equatable {
  const CountState({this.pagePos = 0});

  final int pagePos;

  @override
  List<Object> get props => [pagePos];
}

final class CountInitial extends CountState {}

final class UpdatePosition extends CountState {
  const UpdatePosition({required super.pagePos});
}
