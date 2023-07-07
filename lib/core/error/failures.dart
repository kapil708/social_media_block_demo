import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  final int statusCode;
  final dynamic data;
  final String message;

  const ServerFailure({
    required this.statusCode,
    this.data,
    required this.message,
  });

  @override
  List<Object?> get props => [statusCode, data, message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
