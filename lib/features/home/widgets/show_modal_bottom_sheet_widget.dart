import 'package:flutter/material.dart';
import 'package:tasky_app/core/widgets/text_form_field_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

class ShowModalBottomSheetWidget extends StatelessWidget {
  const ShowModalBottomSheetWidget({
    super.key,
    this.sendAction,
    this.dateAction,
    this.priorityAction,
    required this.taskTitle,
    required this.taskDescription,
    this.isAddTask = true,
  });
  final TextEditingController taskTitle;
  final TextEditingController taskDescription;
  final void Function()? sendAction;
  final void Function()? dateAction;
  final void Function()? priorityAction;
  final bool isAddTask;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 25,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "add_task".tr(),
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ??
                  AppColors.textMain,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          TextFormFieldHelper(
            hint: "title".tr(),
            controller: taskTitle,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 14),
          TextFormFieldHelper(
            hint: "description".tr(),
            controller: taskDescription,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              GestureDetector(
                onTap: dateAction,
                child: Image.asset(AppAssets.dateIcon),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: priorityAction,
                child: Image.asset(AppAssets.priorityIcon),
              ),
              Spacer(),
              GestureDetector(
                onTap: sendAction,
                child: isAddTask
                    ? Image.asset(AppAssets.sendIcon)
                    : Image.asset(AppAssets.editIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
