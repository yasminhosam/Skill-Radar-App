import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler {
  final String message;
  final int? status;

  ApiErrorHandler._(this.message, this.status);

  static ApiErrorHandler handle(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiErrorHandler._(
            'Connection timed out. Please try again.',
            statusCode,
          );

        case DioExceptionType.connectionError:
          return ApiErrorHandler._(
            'No internet connection. Please check your network.',
            statusCode,
          );

        case DioExceptionType.badResponse:
          if (statusCode == 429) {
            return ApiErrorHandler._(
              'Too many requests try later.',
              statusCode,
            );
          }
          final ApiErrorModel apiErrorModel = ApiErrorModel.fromJson(
            error.response?.data,
          );
          return ApiErrorHandler._(apiErrorModel.errors ?? "", statusCode);

        default:
          return ApiErrorHandler._('Something went wrong. Please try again.', statusCode);
      }
    }
    return ApiErrorHandler._('An unexpected error occurred.', null);
  }

}
