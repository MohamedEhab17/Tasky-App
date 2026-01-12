import 'package:flutter/material.dart';
import 'package:info_toast/info_toast.dart';
import 'package:info_toast/resources/arrays.dart';
import 'package:lottie/lottie.dart';

void customErrorToast(
  BuildContext context, {
  required String title,
  required String message,
}) => InfoToast.error(
  title: Text(title, style: TextStyle(color: Colors.red)),

  iconWidget: SizedBox(
    height: 80,
    child: Lottie.asset('assets/icons/error_icon.json'),
  ),
  animationType: AnimationType.fromTop,
  animationCurve: Curves.easeOutCubic,
  description: Text(message),
).show(context);
