import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';
import 'package:tasky_app/core/widgets/text_form_field_helper.dart';
import 'package:tasky_app/features/home/presentation/view_model/task_cubit/task_cubit.dart';
import 'package:tasky_app/features/home/widgets/custom_category_container_widget.dart';

class HomeHeaderWidget extends StatefulWidget {
  const HomeHeaderWidget({super.key});

  @override
  State<HomeHeaderWidget> createState() => _HomeHeaderWidgetState();
}

class _HomeHeaderWidgetState extends State<HomeHeaderWidget> {
  String selectedCategory = "All";
  DateTime? selectedDate;
  late TextEditingController searchController;

  final ValueNotifier<bool> isMenuOpenNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    isMenuOpenNotifier.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        TextFormFieldHelper(
          hint: "Search for your task...",
          controller: searchController,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondaryLight),
          onChanged: (text) {
            context.read<TaskCubit>().getTasks(search: text);
          },
          borderRadius: BorderRadius.circular(10.r),
          prefixIcon: Image.asset(
            AppAssets.searchIcon,
            height: 24.h,
            width: 24.w,
          ),
        ),
        SizedBox(height: 30.h),

        ValueListenableBuilder<bool>(
          valueListenable: isMenuOpenNotifier,
          builder: (context, isOpen, child) {
            return CustomCategoryContainerWidget(
              title: selectedCategory,
              hasMenu: true,
              isMenuOpen: isOpen,
              onTapDown: (details) async {
                isMenuOpenNotifier.value = true;

                final result = await showMenu<String>(
                  context: context,
                  color: Theme.of(context).cardColor,
                  position: RelativeRect.fromSize(
                    Rect.fromLTWH(
                      details.globalPosition.dx,
                      details.globalPosition.dy,
                      0,
                      0,
                    ),
                    MediaQuery.of(context).size,
                  ),
                  items: const [
                    PopupMenuItem(value: "All", child: Text("All")),
                    PopupMenuItem(value: "Today", child: Text("Today")),
                    PopupMenuItem(value: "Tomorrow", child: Text("Tomorrow")),
                    PopupMenuItem(value: "Next Week", child: Text("Next Week")),
                    PopupMenuItem(
                      value: "Next month",
                      child: Text("Next month"),
                    ),
                  ],
                );

                isMenuOpenNotifier.value = false;

                if (result != null) {
                  DateTime now = DateTime.now();
                  DateTime? calculatedDate;

                  switch (result) {
                    case "All":
                      calculatedDate = null;
                    case "Today":
                      calculatedDate = DateTime(now.year, now.month, now.day);
                    case "Tomorrow":
                      calculatedDate = now.add(const Duration(days: 1));
                    case "Next Week":
                      calculatedDate = now.add(const Duration(days: 7));
                    case "Next month":
                      calculatedDate = DateTime(
                        now.year,
                        now.month + 1,
                        now.day,
                      );
                  }

                  setState(() {
                    selectedCategory = result;
                    selectedDate = calculatedDate;
                  });

                  if (calculatedDate != null) {
                    context.read<TaskCubit>().getTasks(date: selectedDate);
                  } else {
                    context.read<TaskCubit>().getTasks(clearDate: true);
                  }
                }
              },
            );
          },
        ),
      ],
    );
  }
}
