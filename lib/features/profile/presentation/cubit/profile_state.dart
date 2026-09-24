sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSaveSuccess extends ProfileState {
  const ProfileSaveSuccess();
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}
