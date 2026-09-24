import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/core/enums/experience_level.dart';
import 'package:flutter_projects/features/profile/data/repo/user_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepo _userRepo;

  ProfileCubit(this._userRepo) : super(const ProfileInitial());

  Future<void> saveProfile({
    required String uid,
    required String targetRole,
    required List<String> skills,
    required ExperienceLevel experienceLevel,
  }) async {
    emit(const ProfileLoading());
    try {
      await _userRepo.updateProfile(
        uid: uid,
        targetRole: targetRole,
        skills: skills,
        experienceLevel: experienceLevel.label,
      );
      emit(const ProfileSaveSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}