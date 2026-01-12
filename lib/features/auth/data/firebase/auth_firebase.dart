import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';

class AuthFirebase {
  final FirebaseAuth firebaseAuth;

  AuthFirebase({required this.firebaseAuth});

  Future<void> login(UserModel userModel) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: userModel.email!,
      password: userModel.password!,
    );
  }

  Future<void> register(UserModel userModel) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: userModel.email!,
      password: userModel.password!,
    );
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // sendEmailVerification? It was in original.
  Future<void> sendEmailVerification() async {
    await firebaseAuth.currentUser!.sendEmailVerification();
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    final user = firebaseAuth.currentUser;
    if (user == null) throw Exception("User not found");

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPassword);
  }
}
