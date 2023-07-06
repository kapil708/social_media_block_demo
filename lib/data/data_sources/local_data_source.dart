import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';

abstract class LocalDataSource {
  Future<bool> isLogin();
  Future<void> cacheAuthToken(String authToken);
}

const _authToken = 'authToken';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> isLogin() {
    try {
      final String? jsonString = sharedPreferences.getString(_authToken);
      if (jsonString != null) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on Exception catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAuthToken(String authToken) {
    return sharedPreferences.setString(_authToken, jsonEncode(authToken));
  }
}