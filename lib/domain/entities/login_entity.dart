import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LoginEntity extends Equatable {
  @JsonKey(name: 'auth_token')
  final String authToken;

  const LoginEntity({required this.authToken});

  @override
  List<Object?> get props => [authToken];
}
