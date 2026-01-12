import 'package:tasky_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tasky_app/core/helper/custom_error_toast.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_cubit.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_state.dart';
import 'package:tasky_app/features/home/widgets/home_header_widget.dart';
import 'package:tasky_app/features/home/widgets/task_item_widget.dart';

class TaskViewWidget extends StatelessWidget {
  const TaskViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskFailure) {
          customErrorToast(
            context,
            title: "error".tr(),
            message: state.message,
          );
        }
        if (state is TaskActionError) {
          customErrorToast(
            context,
            title: "error".tr(),
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: CustomScrollView(
            slivers: [
              // 🔍 Search & Category
              SliverToBoxAdapter(child: HomeHeaderWidget()),

              // 📋 Tasks List
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              if (state is TaskLoading)
                Skeletonizer.sliver(
                  enabled: true,
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      childCount: 5,
                    ),
                  ),
                )
              else if (state is TaskSuccess) ...[
                if (state.tasks.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.emptyTask,
                            height: 200.h,
                            width: 200.w,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.assignment,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text("No tasks found"),
                        ],
                      ),
                    ),
                  )
                else
                  SliverMainAxisGroup(
                    slivers: [
                      // ACTIVE TASKS
                      SliverToBoxAdapter(
                        child: Text(
                          "My Tasks",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 10.h)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final activeTasks = state.tasks
                                .where((t) => !(t.isCompleted ?? false))
                                .toList();
                            if (index >= activeTasks.length) return SizedBox();

                            final task = activeTasks[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 15.h),
                              child: Dismissible(
                                key: Key(task.id!),
                                direction: DismissDirection.horizontal,
                                onDismissed: (direction) {
                                  context.read<TaskCubit>().deleteTask(task);
                                },
                                background: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                secondaryBackground: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.w),
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: TaskItemWidget(
                                  task: task,
                                  complete: () {
                                    context.read<TaskCubit>().toggleTask(task);
                                  },
                                  onTap: () {
                                    context.push(
                                      AppRoutes.taskDetails,
                                      extra: task,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: state.tasks
                              .where((t) => !(t.isCompleted ?? false))
                              .length,
                        ),
                      ),

                      // COMPLETED TASKS
                      if (state.tasks.any((t) => t.isCompleted ?? false)) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: Text(
                              "completed".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMain,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final completedTasks = state.tasks
                                  .where((t) => t.isCompleted ?? false)
                                  .toList();
                              if (index >= completedTasks.length) {
                                return SizedBox();
                              }

                              final task = completedTasks[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: Dismissible(
                                  key: Key(task.id!),
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (direction) {
                                    context.read<TaskCubit>().deleteTask(task);
                                  },
                                  background: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.w),
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.only(right: 20.w),
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: TaskItemWidget(
                                    task: task,
                                    complete: () {
                                      context.read<TaskCubit>().toggleTask(
                                        task,
                                      );
                                    },
                                    onTap: () {
                                      context.push(
                                        AppRoutes.taskDetails,
                                        extra: task,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            childCount: state.tasks
                                .where((t) => t.isCompleted ?? false)
                                .length,
                          ),
                        ),
                      ],
                    ],
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
