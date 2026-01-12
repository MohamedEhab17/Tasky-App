import 'package:flutter/material.dart';
import 'package:info_toast/info_toast.dart';
import 'package:info_toast/resources/arrays.dart';
import 'package:lottie/lottie.dart';

void customSuccessToast(
  BuildContext context, {
  required String title,
  String? message,
}) => InfoToast.success(
  title: Text(title, style: TextStyle(color: Colors.green)),

  iconWidget: SizedBox(
    height: 80,
    child: Lottie.asset('assets/icons/success_icon.json'),
  ),
  animationType: AnimationType.fromTop,
  animationCurve: Curves.easeOutCubic,
  description: Text(message ?? ""),
).show(context);
