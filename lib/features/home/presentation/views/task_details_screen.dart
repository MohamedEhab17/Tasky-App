import 'package:flutter/material.dart';
import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Responsive
import 'package:easy_localization/easy_localization.dart'; // Localization
import 'package:tasky_app/core/helper/format_date.dart';
import 'package:tasky_app/core/widgets/custom_elevated_button.dart';
import 'package:tasky_app/features/home/data/model/task_model.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_cubit.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_state.dart';
import 'package:tasky_app/features/home/widgets/custom_details_app_bar.dart';
import 'package:tasky_app/features/home/widgets/custom_radio_button.dart';
import 'package:tasky_app/features/home/widgets/show_modal_bottom_sheet_widget.dart';
import 'package:tasky_app/features/home/widgets/show_priority_widget.dart';
import 'package:tasky_app/features/home/widgets/task_details_list_tile_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/helper/custom_success_toast.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});
  static const routeName = '/task-details-screen';
  final TaskModel task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskActionSuccess) {
          context.go(AppRoutes.home);
          customSuccessToast(context, title: state.message);
        }
        if (state is TaskActionError) {
          customErrorToast(
            context,
            title: "error".tr(),
            message: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: CustomDetailsAppBar(onTap: () => context.pop()),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 11.h),
          child: Column(
            spacing: 30.h,
            children: [
              Row(
                spacing: 13.w,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<TaskCubit>().toggleTask(widget.task);
                      setState(() {});
                    },
                    child: CustomRadioButton(
                      isSelected: widget.task.isCompleted ?? false,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15.h,
                      children: [
                        Text(
                          widget.task.title ?? "",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          widget.task.description ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ShowModalBottomSheetWidget(
                          taskTitle: titleController,
                          taskDescription: descriptionController,
                          isAddTask: false,
                          dateAction: () async {
                            selectedDate =
                                await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now().subtract(
                                    const Duration(days: 365),
                                  ),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                  initialDate: selectedDate,
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
                                initialIndex: selectedPriority,
                                selectedPriority: (int selectedIndex) {
                                  selectedPriority = selectedIndex;
                                },
                              ),
                            );
                          },
                          sendAction: () {
                            context.read<TaskCubit>().updateTask(
                              widget.task.copyWith(
                                title: titleController.text,
                                description: descriptionController.text,
                                date: selectedDate,
                                priority: selectedPriority,
                              ),
                            );
                            titleController.clear();
                            descriptionController.clear();
                            // Navigation handled by listener
                          },
                        ),
                      );
                    },
                    icon: Image.asset(
                      AppAssets.editIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              TaskDetailsListTileWidget(
                iconPath: AppAssets.dateIcon,
                title: "end_date".tr(),
                trailingText: getSmartDayLabel(widget.task.date!),
              ),
              TaskDetailsListTileWidget(
                iconPath: AppAssets.priorityIcon,
                title: "priority".tr(),
                trailingText: widget.task.priority == 1
                    ? "Default"
                    : widget.task.priority.toString(),
              ),
              TaskDetailsListTileWidget(
                iconPath: AppAssets.deleteIcon,
                title: "delete".tr(),
                onTap: () {
                  context.read<TaskCubit>().deleteTask(widget.task);
                },
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: CustomElevatedButton(
            width: double.infinity,
            height: 48.h,
            text: widget.task.isCompleted! ? "in_progress".tr() : "done".tr(),
            onPressed: () {
              context.read<TaskCubit>().toggleTask(widget.task);
            },
          ),
        ),
      ),
    );
  }

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(
      text: widget.task.description,
    );
    selectedDate = widget.task.date!;
    selectedPriority = widget.task.priority ?? 0;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
