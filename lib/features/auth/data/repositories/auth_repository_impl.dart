import 'package:tasky_app/features/auth/data/firebase/auth_firebase.dart';
import 'package:tasky_app/features/auth/data/firebase/user_firebase.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebase authFirebase;
  final UserFirebase userFirebase;

  AuthRepositoryImpl({required this.authFirebase, required this.userFirebase});

  @override
  Future<void> login(UserModel userModel) async {
    await authFirebase.login(userModel);
  }

  @override
  Future<void> register(UserModel userModel) async {
    await authFirebase.register(userModel);
    // After accurate registration, add user to Firestore
    // Note: userModel.password might be in the model but ideally shouldn't be saved to DB.
    // The original code passed the whole model. I will keep it but it's a security note.
    await userFirebase.addUser(userModel);
  }

  @override
  Future<void> logout() async {
    await authFirebase.logout();
  }

  @override
  Future<UserModel> getUserProfile() async {
    final user = await userFirebase.getUser();
    if (user != null) return user;

    // Fallback if not found in Firestore (should not happen if flow is correct)
    final currentUser = authFirebase.firebaseAuth.currentUser;
    if (currentUser != null) {
      return UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName ?? "User",
      );
    }
    throw Exception("User not logged in");
  }

  @override
  Future<void> updateUser(UserModel userModel) async {
    await userFirebase.addUser(
      userModel,
    ); // Reuse addUser (set) or allow generic update
    // If auth profile update is needed (e.g. displayName in FirebaseAuth):
    // await authFirebase.updateProfile(userModel.name);
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    await authFirebase.changePassword(currentPassword, newPassword);
    // Sync with Firestore as requested
    final uid = authFirebase.firebaseAuth.currentUser?.uid;
    if (uid != null) {
      await userFirebase.updatePassword(uid, newPassword);
    }
  }
}
