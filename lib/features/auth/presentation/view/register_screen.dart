import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/helper/custom_success_toast.dart';
import 'package:tasky_app/core/widgets/custom_elevated_button.dart';
import 'package:tasky_app/core/widgets/text_form_field_helper.dart';
import 'package:tasky_app/core/widgets/validator.dart';
import 'package:tasky_app/features/auth/data/model/user_model.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:tasky_app/features/auth/presentation/widgets/custom_rich_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          context.pop();
          customSuccessToast(context, title: "register_success".tr());
        }
        if (state is RegisterError) {
          customErrorToast(
            context,
            title: "error".tr(),
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: state is RegisterLoading,
              progressIndicator: SpinKitWaveSpinner(
                color: Theme.of(context).primaryColor,
                waveColor: Theme.of(context).primaryColor.withAlpha(200),
                size: 80.r,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 90.h),
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    spacing: 11.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'register'.tr(),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                      ),
                      SizedBox(height: 17.h),
                      Text(
                        'name'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextFormFieldHelper(
                        controller: userName,
                        keyboardType: TextInputType.name,
                        onValidate: Validator.validateName,
                        hint: 'name'.tr(), // "enter username..."
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      Text(
                        'email'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextFormFieldHelper(
                        hint: 'email'.tr(),
                        keyboardType: TextInputType.emailAddress,
                        borderRadius: BorderRadius.circular(10.r),
                        onValidate: Validator.validateEmail,
                        controller: email,
                      ),
                      Text(
                        'password'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextFormFieldHelper(
                        hint: 'password'.tr(),
                        controller: password,
                        isPassword: true,
                        onValidate: Validator.validatePassword,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      Text(
                        'Confirm Password', // Key missing, assume "confirm_password" or hardcode
                        // I'll add key later or just use string.
                        // using hardcoded for now to avoid breaking if key missing
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextFormFieldHelper(
                        hint: 'password'.tr(),
                        isPassword: true,
                        controller: confirmPassword,
                        borderRadius: BorderRadius.circular(10.r),
                        onValidate: (val) {
                          return Validator.validateConfirmPassword(
                            confirmPassword.text,
                            password.text,
                          );
                        },
                      ),
                      SizedBox(height: 70.h),
                      CustomElevatedButton(
                        width: double.infinity,
                        height: 48.h,
                        text: 'register'.tr(),
                        onPressed: () async {
                          if (registerFormKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              UserModel(
                                email: email.text.trim(),
                                password: password.text.trim(),
                                name: userName.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: CustomRichText(
                    firstText: 'Already have an account? '.tr(),
                    secondText: 'login'.tr(),
                    onTap: () {
                      context.pop();
                    },
                  ),
                )
              : SizedBox.shrink(),
        );
      },
    );
  }
}
