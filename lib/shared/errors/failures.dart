import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final dynamic statusCode;
  final String message;
  final String? code;

  const Failure({
    this.statusCode,
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [statusCode, message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.statusCode,
    required super.message,
    super.code,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.statusCode,
    required super.message,
    super.code,
  });
}

class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
  });
}
