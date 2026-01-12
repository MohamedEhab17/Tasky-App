import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          email.clear();
          password.clear();
          context.go(AppRoutes.home);
          customSuccessToast(context, title: "Login Successfully");
        }
        if (state is LoginError) {
          customErrorToast(
            context,
            title: "Login Failure",
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: state is LoginLoading,
              progressIndicator: SpinKitWaveSpinner(
                color: AppColors.primary,
                waveColor: AppColors.primary.withAlpha(200),
                size: 80,
              ),

              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 90.h),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'login'.tr(),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.color,
                            ),
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        'email'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8.h),
                      TextFormFieldHelper(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        hint: 'email'.tr(),
                        onValidate: Validator.validateEmail,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      SizedBox(height: 26.h),
                      Text(
                        'password'.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 8.h),
                      TextFormFieldHelper(
                        hint: 'password'.tr(),
                        controller: password,
                        isPassword: true,
                        onValidate: Validator.validatePassword,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      SizedBox(height: 70.h),
                      CustomElevatedButton(
                        width: double.infinity,
                        height: 48.h,
                        text: 'login'.tr(),
                        onPressed: () async {
                          if (loginFormKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              UserModel(
                                email: email.text.trim(),
                                password: password.text.trim(),
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
                    firstText: "Don't have an account? ".tr(),
                    secondText: 'register'.tr(),
                    onTap: () {
                      context.push('/register');
                    },
                  ),
                )
              : SizedBox.shrink(),
        );
      },
    );
  }
}
