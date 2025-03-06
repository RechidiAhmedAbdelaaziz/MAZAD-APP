import 'package:dio/dio.dart';

import 'models/api_error.model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return const ApiErrorModel(
              message: "Connection to server failed");
        case DioExceptionType.cancel:
          return const ApiErrorModel(
              message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return const ApiErrorModel(
              message: "Connection timeout with the server");
        case DioExceptionType.unknown:
          return const ApiErrorModel(
              message:
                  "Connection to the server failed due to internet connection");
        case DioExceptionType.receiveTimeout:
          return const ApiErrorModel(
              message:
                  "Receive timeout in connection with the server");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return const ApiErrorModel(
              message: "Send timeout in connection with the server");
        default:
          return const ApiErrorModel(message: "Something went wrong");
      }
    } else {
      return const ApiErrorModel(message: "Something went wrong");
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  data as Map<String, dynamic>?;
  return ApiErrorModel.fromJson(data);
}
