import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_block_demo/core/error/exceptions.dart';
import 'package:social_media_block_demo/data/models/login/login_model.dart';

part 'api_methods.dart';

abstract class RemoteDataSource {
  Future<LoginModel> login(Map<String, dynamic> body);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(Map<String, dynamic> body) async {
    String url = '$baseUrl${ApiMethods.login}';

    final http.Response response = await client.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("::: data : $data");
      return LoginModel.fromJson(data['data']);
    } else {
      var data = jsonDecode(response.body);
      throw ServerException(
        statusCode: response.statusCode,
        data: data['data'],
        message: data['message'] ?? 'Server exception',
      );
    }
  }

  @override
  Future<LoginModel> getData({required String username, required String password}) async {
    String url = '$baseUrl${ApiMethods.login}';

    final http.Response response = await client.get(
      Uri.parse('$baseUrl${ApiMethods.login}'),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return LoginModel.fromJson(data['data']);
    } else {
      var data = jsonDecode(response.body);
      throw ServerException(
        statusCode: response.statusCode,
        data: data['data'],
        message: data['message'] ?? 'Server exception',
      );
    }
  }
}
