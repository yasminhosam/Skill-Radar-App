import 'job_model.dart';

class JobSearchResponse {
  final int? limit;
  final int? totalCount;
  final String? nextCursor;
  final List<Job> jobs;

  JobSearchResponse({
    this.limit,
    this.totalCount,
    this.nextCursor,
    this.jobs = const [],
  });

  factory JobSearchResponse.fromJson(Map<String, dynamic> json) {
    return JobSearchResponse(
      limit: json['limit'],
      totalCount: json['totalCount'],
      nextCursor: json['nextCursor'],
      jobs: (json['jobs'] as List?)
          ?.map((v) => Job.fromJson(v as Map<String, dynamic>))
          .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'totalCount': totalCount,
      'nextCursor': nextCursor,
      'jobs': jobs.map((v) => v.toJson()).toList(),
    };
  }
}