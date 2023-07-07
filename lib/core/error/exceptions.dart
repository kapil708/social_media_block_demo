class ServerException implements Exception {
  final int statusCode;
  final dynamic data;
  final String message;

  ServerException({
    required this.statusCode,
    this.data,
    required this.message,
  });
}

class CacheException implements Exception {}
