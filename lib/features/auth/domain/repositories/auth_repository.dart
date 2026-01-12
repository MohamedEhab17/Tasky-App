import 'package:tasky_app/features/auth/data/model/user_model.dart';

abstract class AuthRepository {
  Future<void> login(UserModel userModel);
  Future<void> register(UserModel userModel);
  Future<void> logout();
  Future<UserModel> getUserProfile();
  Future<void> updateUser(UserModel userModel);
  Future<void> changePassword(String currentPassword, String newPassword);
}
