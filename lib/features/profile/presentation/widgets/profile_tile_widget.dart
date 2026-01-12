import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTileWidget extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool showDivider;

  const ProfileTileWidget({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? Colors.red
        : Theme.of(context).textTheme.bodyLarge?.color;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                children: [
                  if (leading != null) ...[leading!, SizedBox(width: 16.w)],
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: 8.w),
                    trailing!,
                  ] else if (onTap != null) ...[
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: Colors.grey.withAlpha(100),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: EdgeInsets.only(left: leading != null ? 48.w : 16.w),
            child: Divider(
              height: 1,
              color: Theme.of(context).dividerColor.withAlpha(50),
            ),
          ),
      ],
    );
  }
}
