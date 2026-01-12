import 'package:flutter/material.dart';

class TaskDetailsListTileWidget extends StatelessWidget {
  const TaskDetailsListTileWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.trailingText,
    this.onTap,
  });
  final String iconPath;
  final String title;
  final String? trailingText;

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Image.asset(iconPath, width: 24, height: 24),

      title: Text(title),
      trailing: trailingText == null
          ? null
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6E6A7C).withAlpha(54),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: onTap,
              child: Text(
                trailingText ?? "",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }
}
