import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  Future<void> login(UserModel userModel) async {
    emit(LoginLoading());
    try {
      await authRepository.login(userModel);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(getErrorMessage(e.code)));
    } catch (e) {
      emit(LoginError("Something went wrong. Please try again."));
    }
  }

  Future<void> register(UserModel userModel) async {
    emit(RegisterLoading());
    try {
      await authRepository.register(userModel);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(getErrorMessage(e.code)));
    } catch (e) {
      emit(RegisterError("Something went wrong. Please try again."));
    }
  }

  Future<void> logout() async {
    try {
      emit(LogoutLoading());
      await authRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError("Something went wrong. Please try again."));
    }
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        return "No account found for this email.";
      case "wrong-password":
        return "Incorrect password. Please try again.";
      case "invalid-email":
        return "Invalid email format.";
      case "user-disabled":
        return "This account has been disabled.";
      case "email-already-in-use":
        return "This email is already registered.";
      case "weak-password":
        return "Password is too weak. Please use a stronger one.";
      case "invalid-credential":
        return "The login credentials are invalid. Please check your email and password.";
      default:
        return "An unexpected error occurred. Please try again later.";
    }
  }
}
