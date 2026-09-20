import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constant.dart';

class DioFactory{
  static late Dio _dio;

  static getDio(){
    _dio=Dio(BaseOptions(
      baseUrl: ApiConstant.himalayasBaseUrl,
      receiveTimeout: ApiConstant.receiveTimeoutSeconds,
      connectTimeout: ApiConstant.connectTimeoutSeconds
    ));

    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,

    )
    );
    return _dio;
  }
}