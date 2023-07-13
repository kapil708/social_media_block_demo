import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LoginEntity extends Equatable {
  @JsonKey(name: 'token')
  final String token;

  const LoginEntity({required this.token});

  @override
  List<Object?> get props => [token];
}
