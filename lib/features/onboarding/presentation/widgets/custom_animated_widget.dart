import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({
    super.key,
    required this.index,
    required this.delay,
    required this.child,
  });
  final int index;
  final int delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (index == 1) {
      return FadeInDown(
        duration: Duration(
          milliseconds: delay > 0 ? delay : 300,
        ), // Safety check
        child: child,
      );
    } else {
      return FadeInUp(
        delay: Duration(milliseconds: delay > 0 ? delay : 300),
        child: child,
      );
    }
  }
}
