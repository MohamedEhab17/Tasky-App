import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tasky_app/features/home/widgets/priority_item_widget.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

class ShowPriorityWidget extends StatefulWidget {
  const ShowPriorityWidget({
    super.key,
    this.isSelected = true,
    required this.selectedPriority,
    this.initialIndex = 1,
  });
  final bool isSelected;
  final int initialIndex;
  final void Function(int selectedIndex) selectedPriority;

  @override
  State<ShowPriorityWidget> createState() => _ShowPriorityWidgetState();
}

class _ShowPriorityWidgetState extends State<ShowPriorityWidget> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),

        title: Column(
          children: [
            Text(
              "priority".tr(),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: AppColors.divider, thickness: 1),
          ],
        ),
        content: Wrap(
          spacing: 16,
          alignment: WrapAlignment.start,
          runSpacing: 11,
          children: List.generate(
            10,
            (index) => PriorityItemWidget(
              isSelected: index + 1 == selectedIndex ? true : false,
              index: index + 1,
              onTap: () {
                selectedIndex = index + 1;
                widget.selectedPriority(selectedIndex);
                setState(() {});
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              "cancel".tr(),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              widget.selectedPriority(selectedIndex);
              context.pop();
            },
            child: Text(
              "save".tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.initialIndex;
    super.initState();
  }
}
