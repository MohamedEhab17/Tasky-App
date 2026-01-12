import 'package:flutter/material.dart';

class CustomDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDetailsAppBar({super.key, this.onTap, this.title});
  final void Function()? onTap;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 20, top: 11),
              decoration: BoxDecoration(
                color: Color(0xff6E6A7C).withAlpha(54),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).iconTheme.color,
                size: 24,
              ),
            ),
          ),
          if (title != null) ...[
            SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
