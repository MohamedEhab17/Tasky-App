import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/helper/custom_success_toast.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/custom_elevated_button.dart';
import 'package:tasky_app/core/widgets/text_form_field_helper.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_state.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "change_password".tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldHelper(
                      controller: currentPasswordController,
                      hint: "current_password".tr(),
                      isPassword: true,
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return "current_password_required".tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),
                    TextFormFieldHelper(
                      controller: newPasswordController,
                      hint: "new_password".tr(),
                      isPassword: true,
                      onValidate: (value) {
                        if (value == null || value.length < 6) {
                          return "password_length_error".tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is PasswordChangeSuccess) {
                    Navigator.pop(context);
                    customSuccessToast(context, title: "password_updated".tr());
                  }
                  if (state is ProfileError) {
                    customErrorToast(
                      context,
                      title: "error".tr(),
                      message: state.message.tr(),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    text: state is ProfileLoading
                        ? "updating".tr()
                        : "update_password".tr(),
                    height: 50.h,
                    width: double.infinity,
                    color: AppColors.primary,
                    onPressed: state is ProfileLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProfileCubit>().changePassword(
                                currentPasswordController.text,
                                newPasswordController.text,
                              );
                            }
                          },
                  );
                },
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "cancel".tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
