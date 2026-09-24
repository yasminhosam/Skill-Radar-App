import '../../data/models/job_model.dart';

sealed class JobState {
  const JobState();
}

class JobInitial extends JobState {
  const JobInitial();
}

class JobLoading extends JobState {
  const JobLoading();
}

class JobSuccess extends JobState {
  final List<Job> jobs;
  final int totalCount;

  const JobSuccess({required this.jobs, required this.totalCount});
}

class JobEmpty extends JobState {
  const JobEmpty();
}

class JobError extends JobState {
  final String message;
  const JobError(this.message);
}