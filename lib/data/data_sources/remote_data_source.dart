import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_block_demo/core/error/exceptions.dart';
import 'package:social_media_block_demo/data/models/login/login_model.dart';

import '../../injection_container.dart';
import 'local_data_source.dart';

part 'api_methods.dart';

abstract class RemoteDataSource {
  Future<LoginModel> login(Map<String, dynamic> body);
}

Map<String, String>? get _headers => {'Accept': 'application/json', 'Content-Type': 'application/json'};

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(Map<String, dynamic> body) async {
    Uri url = Uri.parse('$baseUrl${ApiMethods.login}');

    final http.Response response = await client.post(
      url,
      body: jsonEncode(body),
      headers: _headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return LoginModel.fromJson(data['data']);
    } else {
      return Future.error(handleErrorResponse(response));
    }
  }

  Future<LoginModel> getData({required String username, required String password}) async {
    final LocalDataSource localDatSource = locator.get<LocalDataSource>();

    Uri url = Uri.parse('$baseUrl${ApiMethods.login}');
    String authToken = localDatSource.getAuthToken() ?? '';

    final http.Response response = await client.get(
      url,
      headers: {
        ...?_headers,
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return LoginModel.fromJson(data['data']);
    } else {
      return Future.error(handleErrorResponse(response));
    }
  }
}

Exception handleErrorResponse(http.Response response) {
  var data = jsonDecode(response.body);

  if (response.statusCode == 422) {
    return ValidationException(
      errors: data['errors'],
      message: data['message'] ?? 'Validation failed',
    );
  } else {
    return ServerException(
      statusCode: response.statusCode,
      message: data['message'] ?? 'Server exception',
    );
  }
}
