import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onTap,
  });
  final String firstText;
  final String secondText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: firstText,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
        ),
        children: [
          const WidgetSpan(child: SizedBox(width: 6)),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: secondText,
            style: TextStyle(
              color: Color(0xff5F33E1),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
