import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({super.key, this.isSelected = false});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(1.5),
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CircleAvatar(
        backgroundColor: isSelected ? AppColors.primary : Colors.transparent,
      ),
    );
  }
}
