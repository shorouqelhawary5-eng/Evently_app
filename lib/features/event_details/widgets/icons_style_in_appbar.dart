import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class IconsAppBar extends StatelessWidget {
  const IconsAppBar({super.key, required this.icon});
  final Image icon;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    final isDarkTheme = themeProvider.currentTheme;

    return Container(
      height: 32.h,
      width: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDarkTheme == ThemeMode.dark
            ? ColorsManager.inputsDark
            : ColorsManager.whiteFF,
        border: Border.all(
          color: isDarkTheme == ThemeMode.dark
              ? ColorsManager.blue8F
              : ColorsManager.gray,
        ),
      ),
      child: icon,
    );
  }
}
