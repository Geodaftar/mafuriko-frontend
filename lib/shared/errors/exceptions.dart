class ServerException implements Exception {
  final String? statusCode;
  final String message;
  final String? code;

  const ServerException({
    this.statusCode,
    required this.message,
    this.code,
  });
}

class CacheException implements Exception {
  final String message;
  final String code;

  const CacheException({required this.message, required this.code});
}
