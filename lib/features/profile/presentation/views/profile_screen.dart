import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/helper/custom_success_toast.dart';
import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:tasky_app/core/theme/cubit/theme_cubit.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:tasky_app/features/home/widgets/custom_details_app_bar.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_state.dart';
import 'package:tasky_app/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:tasky_app/features/profile/presentation/widgets/edit_name_dialog.dart';
import 'package:tasky_app/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:tasky_app/features/profile/presentation/widgets/profile_section_widget.dart';
import 'package:tasky_app/features/profile/presentation/widgets/profile_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.go(AppRoutes.login);
              customSuccessToast(context, title: "Logout Successfully");
            }
            if (state is LogoutError) {
              customErrorToast(context, title: "Error", message: state.message);
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              customSuccessToast(context, title: state.message.tr());
            }
            if (state is ProfileError) {
              customErrorToast(
                context,
                title: "error".tr(),
                message: state.message.tr(),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomDetailsAppBar(
          title: "profile".tr(),
          onTap: () => context.pop(),
        ),
        body: FutureBuilder<UserModel>(
          future: context.read<AuthCubit>().authRepository.getUserProfile(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  ProfileHeaderWidget(
                    email: user?.email,
                    displayName: user?.name ?? user?.email?.split('@').first,
                  ),
                  SizedBox(height: 24.h),

                  // Account Info
                  ProfileSectionWidget(
                    title: "account_information".tr(),
                    children: [
                      ProfileTileWidget(
                        title: "name".tr(),
                        leading: Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                        ),
                        trailing: Row(
                          children: [
                            Text(
                              user?.name ?? "set_name".tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                        onTap: () {
                          if (user != null) {
                            showDialog(
                              context: context,
                              builder: (_) => BlocProvider.value(
                                value: context.read<ProfileCubit>(),
                                child: EditNameDialog(user: user),
                              ),
                            ).then((_) {
                              // Trigger refresh if needed, usually setState or Cubit Fetch
                              (context as Element).markNeedsBuild();
                            });
                          }
                        },
                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // App Settings
                  ProfileSectionWidget(
                    title: "app_settings".tr(),
                    children: [
                      ProfileTileWidget(
                        title: "theme".tr(),
                        leading: Icon(
                          Icons.palette_outlined,
                          color: AppColors.primary,
                        ),
                        trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, mode) {
                            return Switch(
                              value: mode == ThemeMode.dark,
                              activeThumbColor: AppColors.primary,
                              onChanged: (value) {
                                context.read<ThemeCubit>().changeTheme(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                            );
                          },
                        ),
                        showDivider: true,
                      ),
                      ProfileTileWidget(
                        title: "language".tr(),
                        leading: Icon(Icons.language, color: AppColors.primary),
                        trailing: DropdownButton<Locale>(
                          value: context.locale,
                          underline: SizedBox(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.primary,
                          ),
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null) {
                              context.setLocale(newLocale);
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: Locale('en'),
                              child: Text("English"),
                            ),
                            DropdownMenuItem(
                              value: Locale('ar'),
                              child: Text("العربية"),
                            ),
                          ],
                        ),
                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Security
                  ProfileSectionWidget(
                    title: "security".tr(),
                    children: [
                      ProfileTileWidget(
                        title: "change_password".tr(),
                        leading: Icon(
                          Icons.lock_outline,
                          color: AppColors.primary,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<ProfileCubit>(),
                              child: const ChangePasswordDialog(),
                            ),
                          );
                        },
                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // App Info & Logout
                  ProfileSectionWidget(
                    title: "app_info".tr(),
                    children: [
                      ProfileTileWidget(
                        title: "app_version".tr(),
                        leading: Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                        ),
                        trailing: Text(
                          "v1.0.0",
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        ),
                        showDivider: true,
                      ),
                      ProfileTileWidget(
                        title: "terms_conditions".tr(),
                        leading: Icon(
                          Icons.description_outlined,
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                        showDivider: true,
                      ),
                      ProfileTileWidget(
                        title: "privacy_policy".tr(),
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: AppColors.primary,
                        ),
                        onTap: () {},
                        showDivider: true,
                      ),
                      ProfileTileWidget(
                        title: "logout".tr(),
                        leading: Icon(Icons.logout, color: Colors.red),
                        isDestructive: true,
                        showDivider: false,
                        onTap: () {
                          _showLogoutDialog(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("logout".tr()),
        content: Text("confirm_logout".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr(), style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().logout();
            },
            child: Text("logout".tr(), style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
