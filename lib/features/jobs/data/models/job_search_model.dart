import 'job_model.dart';

class JobSearchResponse {
  final int limit;
  final int totalCount;
  final String? nextCursor;
  final List<Job> jobs;

  const JobSearchResponse({
    required this.limit,
    required this.totalCount,
    this.nextCursor,
    required this.jobs,
  });

  factory JobSearchResponse.fromJson(Map<String, dynamic> json) {
    final rawJobs = json['jobs'] as List? ?? const [];
    return JobSearchResponse(
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      nextCursor: json['nextCursor'] as String?,
      jobs: rawJobs
          .map((e) => Job.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'limit': limit,
    'totalCount': totalCount,
    'nextCursor': nextCursor,
    'jobs': jobs.map((j) => j.toJson()).toList(),
  };
}