import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Image.asset(AppAssets.emptyTask),
          const SizedBox(height: 15),
          Text(
            "What do you want to do today?",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),

          Text(
            "Tap + to add your tasks",
            style: TextStyle(
              color: Color(0xff24252C),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
