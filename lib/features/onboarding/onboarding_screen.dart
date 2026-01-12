import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Responsive
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky_app/core/widgets/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/di/service_locator.dart';
import 'package:tasky_app/core/services/cache_helper.dart';
import 'package:tasky_app/features/onboarding/data/model/on_boarding_model.dart';
import 'package:tasky_app/features/onboarding/presentation/widgets/custom_animated_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const routeName = 'OnBoardingScreen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageViewController = PageController();

  int currentPage = 0;
  List<OnBoardingModel> onboardingList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize data here to access translations
    onboardingList = [
      OnBoardingModel(
        imgPath: AppAssets.onboarding1,
        title: 'onboarding_1_title'.tr(),
        description: 'onboarding_1_desc'.tr(),
      ),
      OnBoardingModel(
        imgPath: AppAssets.onboarding2,
        title: 'onboarding_2_title'.tr(),
        description: 'onboarding_2_desc'.tr(),
      ),
      OnBoardingModel(
        imgPath: AppAssets.onboarding3,
        title: 'onboarding_3_title'.tr(),
        description: 'onboarding_3_desc'.tr(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0.w, vertical: 80.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250.h,
                child: PageView.builder(
                  controller: pageViewController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onboardingList.length,
                  itemBuilder: (context, index) => CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: Image.asset(
                      onboardingList[index].imgPath,
                      width: 200.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              //! indicator
              SmoothPageIndicator(
                controller: pageViewController,
                count: onboardingList.length,
                effect: ExpandingDotsEffect(
                  spacing: 10.w,
                  radius: 10.r,
                  dotWidth: 15.w,
                  dotHeight: 5.h,
                  dotColor: AppColors.greyUnselected,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 50.h),
              //! Title
              CustomAnimatedWidget(
                delay: (currentPage + 1) * 100,
                index: currentPage,
                child: Column(
                  children: [
                    Text(
                      onboardingList[currentPage].title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      onboardingList[currentPage].description,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).textTheme.bodyMedium?.color ??
                            AppColors.textSecondaryLight,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: CustomElevatedButton(
        height: 48.h,
        text: currentPage == 2 ? 'get_started'.tr() : 'next'.tr(),
        width: 120.w,
        onPressed: () {
          if (currentPage < 2) {
            pageViewController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          } else {
            getIt<CacheHelper>().saveData(key: 'onBoarding', value: true).then((
              value,
            ) {
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            });
          }
        },
      ),
    );
  }
}
