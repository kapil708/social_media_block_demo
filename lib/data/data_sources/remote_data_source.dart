import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_block_demo/core/error/exceptions.dart';
import 'package:social_media_block_demo/data/models/login/login_model.dart';

abstract class RemoteDataSource {
  Future<LoginModel> login({required String username, required String password});
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login({required String username, required String password}) async {
    final http.Response response = await client.get(
      Uri.parse('uri'),
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
