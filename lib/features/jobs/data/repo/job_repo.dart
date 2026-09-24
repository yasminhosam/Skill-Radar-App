import 'package:dio/dio.dart';
import 'package:flutter_projects/core/networking/api_constant.dart';
import 'package:flutter_projects/core/networking/api_result.dart';
import 'package:flutter_projects/features/jobs/data/models/job_search_model.dart';

import '../../../../core/networking/api_error_handler.dart';

class JobRepo {
  final Dio _dio;

  JobRepo(this._dio);

  Future<ApiResult<JobSearchResponse>> fetchJobs ({
    required String targetRole,
    required String seniority,
    int limit = 20,
    int offset = 0,
}) async{
    try{
      final response = await _dio.get(
        ApiConstant.searchJobs,
        queryParameters: {
          ApiConstant.queryKeyword:targetRole,
          ApiConstant.querySeniority:seniority,
          ApiConstant.queryLimit: limit,
          ApiConstant.queryOffset: offset,
        },
      );
      return Success(
        JobSearchResponse.fromJson(response.data as Map<String,dynamic>)
      );

    }catch(e){
      final error = ApiErrorHandler.handle(e);
      return Failure(error.message, statusCode: error.status);
    }
  }
}