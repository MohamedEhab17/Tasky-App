import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/custom_elevated_button.dart';
import 'package:tasky_app/core/widgets/text_form_field_helper.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:tasky_app/features/profile/presentation/view_model/profile_cubit/profile_state.dart';

class EditNameDialog extends StatefulWidget {
  final UserModel user;

  const EditNameDialog({super.key, required this.user});

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late TextEditingController nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "edit_name".tr(),
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
              child: TextFormFieldHelper(
                controller: nameController,
                hint: "enter_name".tr(),
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "name_required".tr();
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 24.h),
            BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is UserUpdateSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  text: state is ProfileLoading
                      ? "saving".tr()
                      : "save_changes".tr(),
                  height: 50.h,
                  width: double.infinity,
                  color: AppColors.primary,
                  onPressed: state is ProfileLoading
                      ? () {}
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().updateName(
                              widget.user,
                              nameController.text.trim(),
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
    );
  }
}
