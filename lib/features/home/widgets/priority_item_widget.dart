import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget({
    super.key,
    this.isSelected = false,
    required this.index,
    this.onTap,
  });

  final bool isSelected;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: isSelected ? null : Border.all(color: Color(0xff6E6A7C)),
        ),
        child: Column(
          spacing: 7,
          children: [
            Image.asset(
              AppAssets.priorityIcon,
              width: 24,
              height: 24,
              color: isSelected ? AppColors.cardLight : AppColors.primary,
            ),
            Text(
              index.toString(),
              style: TextStyle(
                color: isSelected
                    ? AppColors.cardLight
                    : Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
