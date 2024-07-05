import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mafuriko/shared/errors/failures.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  List<Object> get props => [];
}

class IdParams extends Params {
  final String id;

  IdParams({required this.id});

  @override
  List<String> get props => [id];
}
