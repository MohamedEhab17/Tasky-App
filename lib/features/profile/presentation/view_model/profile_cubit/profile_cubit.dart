import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepository;

  ProfileCubit({required this.authRepository}) : super(ProfileInitial());

  Future<void> updateName(UserModel user, String newName) async {
    emit(ProfileLoading());
    try {
      user.name = newName;
      await authRepository.updateUser(user);
      emit(UserUpdateSuccess("name_updated_success"));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    emit(ProfileLoading());
    try {
      if (newPassword.length < 6) {
        emit(ProfileError("password_length_error"));
        return;
      }
      await authRepository.changePassword(currentPassword, newPassword);
      emit(PasswordChangeSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
