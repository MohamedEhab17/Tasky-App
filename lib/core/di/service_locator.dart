import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky_app/core/services/cache_helper.dart';
import 'package:tasky_app/features/auth/data/firebase/auth_firebase.dart';
import 'package:tasky_app/features/auth/data/firebase/user_firebase.dart';
import 'package:tasky_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tasky_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:tasky_app/features/home/data/firebase/task_firebase.dart';
import 'package:tasky_app/features/home/data/repositories/task_repository_impl.dart';
import 'package:tasky_app/features/home/domain/repositories/task_repository.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_cubit.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:tasky_app/core/theme/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(sharedPreferences: getIt()),
  );
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // --- Auth Feature ---
  // Data Sources
  getIt.registerLazySingleton<AuthFirebase>(
    () => AuthFirebase(firebaseAuth: getIt()),
  );
  getIt.registerLazySingleton<UserFirebase>(
    () => UserFirebase(firestore: getIt(), auth: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authFirebase: getIt(), userFirebase: getIt()),
  );

  // Cubit
  getIt.registerFactory(() => AuthCubit(authRepository: getIt()));

  // --- Home Feature ---
  // Data Sources
  getIt.registerLazySingleton<TaskFirebase>(
    () => TaskFirebase(firestore: getIt(), auth: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(taskFirebase: getIt()),
  );

  // Cubit
  getIt.registerFactory(() => TaskCubit(taskRepository: getIt()));

  // --- Profile Feature ---
  getIt.registerFactory(() => ProfileCubit(authRepository: getIt()));

  // Application
  getIt.registerFactory(() => ThemeCubit(sharedPreferences: getIt()));
}
