import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:tasky_app/features/auth/presentation/view/login_screen.dart';
import 'package:tasky_app/features/auth/presentation/view/register_screen.dart';
import 'package:tasky_app/features/home/presentation/views/home_screen.dart';
import 'package:tasky_app/features/home/presentation/views/task_details_screen.dart';
import 'package:tasky_app/features/splash/presentation/views/splash_screen.dart';
import 'package:tasky_app/features/onboarding/onboarding_screen.dart';
import 'package:tasky_app/features/profile/presentation/views/profile_screen.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.initial,
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.taskDetails,
        builder: (context, state) {
          final task = state.extra as TaskModel;
          return TaskDetailsScreen(task: task);
        },
      ),
    ],
  );
}
