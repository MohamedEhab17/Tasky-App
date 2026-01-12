abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class PasswordChangeSuccess extends ProfileState {}

class UserUpdateSuccess extends ProfileState {
  final String message;
  UserUpdateSuccess(this.message);
}
