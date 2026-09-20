import 'job_model.dart';

class JobSearchResponse {
  int? limit;
  int? totalCount;
  String? nextCursor;
  List<Job>? jobs;

  JobSearchResponse(
      {
        this.limit,
        this.totalCount,
        this.nextCursor,
        this.jobs});

  JobSearchResponse.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    totalCount = json['totalCount'];
    nextCursor = json['nextCursor'];
    if (json['jobs'] != null) {
      jobs = <Job>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Job.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['totalCount'] = this.totalCount;
    data['nextCursor'] = this.nextCursor;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}