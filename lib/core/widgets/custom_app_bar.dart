import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.hasAction = false, this.onPressed});
  final void Function()? onPressed;
  final bool hasAction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SafeArea(
        child: Row(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.taskIcon,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Color(0xff24252C), // Fix color for Dark Mode too
                    height: 28,
                  ),
                  Image.asset(AppAssets.yIcon, height: 28),
                ],
              ),
            ),
            Spacer(),
            hasAction
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.settings,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
