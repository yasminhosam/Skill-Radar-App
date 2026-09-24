import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/networking/api_result.dart';
import '../../data/repo/job_repo.dart';
import 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final JobRepo _jobRepo;

  JobCubit(this._jobRepo) : super(const JobInitial());

  Future<void> fetchJobs({
    required String targetRole,
    required String seniority,
    int limit = 20,
    int offset = 0,
  }) async {
    emit(const JobLoading());

    final result = await _jobRepo.fetchJobs(
      targetRole: targetRole,
      seniority: seniority,
      limit: limit,
      offset: offset,
    );
    if (isClosed) return;

    switch (result) {
      case Success(: final data):
        if(data.jobs.isEmpty){
          emit(const JobEmpty());

        }else{
          emit(JobSuccess(jobs: data.jobs, totalCount: data.totalCount));
        }
      case Failure(message: final message):
        emit(JobError(message));
        break;
    }
  }
}
