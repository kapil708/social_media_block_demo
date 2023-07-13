import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_block_demo/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends LoginEntity {
  // const LoginModel({required String authToken}) : super(authToken: authToken);
  const LoginModel({required super.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
