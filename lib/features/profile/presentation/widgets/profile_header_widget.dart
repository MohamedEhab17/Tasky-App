import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String? email;
  final String? displayName;

  const ProfileHeaderWidget({super.key, this.email, this.displayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(80),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40.r,
              backgroundColor: Theme.of(context).cardColor,
              child: CircleAvatar(
                radius: 36.r,
                backgroundColor: AppColors.primary.withAlpha(20),
                child: Text(
                  email?.isNotEmpty == true
                      ? email!.substring(0, 1).toUpperCase()
                      : "U",
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Name/Email
          Text(
            displayName ?? "default_user".tr(),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            textAlign: TextAlign.center,
          ),
          if (email != null) ...[
            SizedBox(height: 4.h),
            Text(
              email!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withAlpha(150),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
