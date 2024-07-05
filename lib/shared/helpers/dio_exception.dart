import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;
  String? code;
  dynamic statusCode;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        final error = dioError.response;
        message = _handleError(
          error?.statusCode,
          error?.data,
        );
        code = error?.data['code'] ?? 'UNKNOWN_ERROR';
        statusCode = error?.data['statusCode'] ?? 500;
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.connectionError:
        if (dioError.message?.contains("SocketException") ?? false) {
          message = 'No Internet';
          break;
        } else if (dioError.message?.contains('HandshakeException') ?? false) {
          message = 'Response data not found';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'] ?? 'Bad request';
      case 401:
        return error['message'] ?? 'Unauthorized';
      case 403:
        return error['message'] ?? 'Forbidden';
      case 422:
        return error['message'][0] ?? 'Field is invalid';
      case 404:
        return error is String
            ? isHTML(error)
                ? 'Not Found'
                : error
            : error is Map
                ? error['message']
                : 'Not found';
      case 420:
        return 'Session Expired. Please LogIn again';
      case 500:
        return error['message'] ?? 'Internal server error';
      case 502:
        return error['message'] ?? 'Server unavailable';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;

  bool isHTML(String str) {
    final RegExp htmlRegExp = RegExp('<[^>]*>', multiLine: true, caseSensitive: false);
    return htmlRegExp.hasMatch(str);
  }
}
