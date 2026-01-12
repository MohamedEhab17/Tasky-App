import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/services/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    bool isOnboardingVisited =
        getIt<CacheHelper>().getData(key: 'onBoarding') ?? false;

    if (isOnboardingVisited) {
      if (FirebaseAuth.instance.currentUser != null) {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.login);
      }
    } else {
      context.go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: TextDirection.ltr,
          children: [
            FadeInLeft(
              duration: const Duration(milliseconds: 800),
              child: Image.asset(AppAssets.taskIcon),
            ),
            BounceInDown(
              from: 50,
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 800),
              child: Image.asset(AppAssets.yIcon),
            ),
          ],
        ),
      ),
    );
  }
}
