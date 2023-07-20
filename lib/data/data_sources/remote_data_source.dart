import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:social_media_block_demo/core/error/exceptions.dart';
import 'package:social_media_block_demo/data/models/login/login_model.dart';
import 'package:social_media_block_demo/data/models/post/post_model.dart';

import '../../injection_container.dart';
import 'local_data_source.dart';

part 'api_methods.dart';

abstract class RemoteDataSource {
  Future<LoginModel> login(Map<String, dynamic> body);
  Future<List<PostModel>> getPosts(Map<String, dynamic> body);
}

Map<String, String>? get _headers => {'Accept': 'application/json', 'Content-Type': 'application/json'};

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> login(Map<String, dynamic> body) async {
    final http.Response response = await client.post(
      Uri.parse(ApiMethods.login),
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

  @override
  Future<List<PostModel>> getPosts(Map<String, dynamic> body) async {
    final LocalDataSource localDatSource = locator.get<LocalDataSource>();

    String authToken = localDatSource.getAuthToken() ?? '';

    final http.Response response = await client.get(
      getUrlWithParams(ApiMethods.login, body),
      headers: {
        ...?_headers,
        "Authorization": "Bearer $authToken",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data['data'] as List<dynamic>?)?.map((post) => PostModel.fromJson(post)).toList() ?? [];
    } else {
      return Future.error(handleErrorResponse(response));
    }
  }
}

Uri getUrlWithParams(String url, Map<String, dynamic> queryParameters) {
  String urlParams = queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&');

  if (urlParams.isNotEmpty) {
    url += '?$urlParams';
  }

  return Uri.parse(url);
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
