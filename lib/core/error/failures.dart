import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  final int statusCode;
  final String message;

  const ServerFailure({
    required this.statusCode,
    required this.message,
  });

  @override
  List<Object?> get props => [statusCode, message];
}

class ValidationFailure extends Failure {
  final dynamic errors;
  final String message;

  const ValidationFailure({
    this.errors,
    required this.message,
  });

  @override
  List<Object?> get props => [errors, message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
