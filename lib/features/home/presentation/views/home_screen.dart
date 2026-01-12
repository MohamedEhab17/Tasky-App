import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/helper/custom_success_toast.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/custom_app_bar.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:tasky_app/features/auth/presentation/view_model/auth_cubit/auth_state.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_cubit.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_state.dart';
import 'package:tasky_app/features/home/widgets/show_modal_bottom_sheet_widget.dart';
import 'package:tasky_app/features/home/widgets/show_priority_widget.dart';
import 'package:tasky_app/features/home/widgets/task_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(AppRoutes.login);
          customSuccessToast(context, title: "Logout Successfully");
        }
        if (state is LogoutError) {
          customErrorToast(
            context,
            title: "Login Failure",
            message: state.message,
          );
        }
      },
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskActionError) {
            customErrorToast(
              context,
              title: "Task Failure",
              message: state.message,
            );
          }
          if (state is TaskActionSuccess) {
            customSuccessToast(context, title: state.message);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is TaskActionLoading,
            progressIndicator: SpinKitWaveSpinner(
              color: AppColors.primary,
              waveColor: AppColors.primary.withAlpha(200),
              size: 80,
            ),
            child: Scaffold(
              appBar: CustomAppBar(
                hasAction: true,
                onPressed: () {
                  context.push(AppRoutes.profile);
                },
              ),
              body: TaskViewWidget(),
              floatingActionButton: FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => ShowModalBottomSheetWidget(
                      taskTitle: taskTitleController,
                      taskDescription: taskDescriptionController,
                      dateAction: () async {
                        selectedDate =
                            await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                              initialDate: DateTime.now(),
                            ) ??
                            DateTime.now();
                        final now = DateTime.now();
                        selectedDate = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          now.hour,
                          now.minute,
                          now.second,
                        );
                      },
                      priorityAction: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => ShowPriorityWidget(
                            selectedPriority: (int selectedIndex) {
                              selectedPriority = selectedIndex;
                            },
                          ),
                        );
                      },
                      sendAction: () {
                        context.read<TaskCubit>().addTask(
                          TaskModel(
                            title: taskTitleController.text,
                            description: taskDescriptionController.text,
                            date: selectedDate,
                            priority: selectedPriority,
                          ),
                        );
                        taskTitleController.clear();
                        taskDescriptionController.clear();
                        context.pop();
                      },
                    ),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  late TextEditingController taskTitleController;
  late TextEditingController taskDescriptionController;
  DateTime selectedDate = DateTime.now();
  int selectedPriority = 1;
  @override
  void initState() {
    taskTitleController = TextEditingController();
    taskDescriptionController = TextEditingController();
    context.read<TaskCubit>().getTasks();
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }
}
