import 'package:evently_app/models/onboarding_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.model, required this.index});

  final OnBoardingModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(model.image),
          SizedBox(height: 16.h),
          Text(model.title, style: theme.textTheme.headlineMedium),
          SizedBox(height: 16.h),
          Text(model.description, style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}
