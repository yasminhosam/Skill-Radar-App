class ApiConstant {
  static const String himalayasBaseUrl = 'https://himalayas.app/jobs/api';
  static const String searchJobs = '/search';

  static const String queryKeyword = 'q';
  static const String querySeniority = 'seniority';
  static const String queryLimit = 'limit';
  static const String queryOffset = 'offset';

  static const Duration connectTimeoutSeconds = Duration(seconds: 15);
  static const Duration receiveTimeoutSeconds =Duration(seconds: 15);
}