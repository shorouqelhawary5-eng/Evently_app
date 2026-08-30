import 'package:evently_app/features/on_boarding/widgets/style_managment_small_button.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    required this.isSelected,
    this.text,
    this.icon,
    this.onTap,
  });

  final bool isSelected;
  final String? text;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: StyleManagmentSmallButton.getColorBackgroundOfSmallButton(
            themeProvider,
            isSelected,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: icon == null
            ? Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: StyleManagmentSmallButton.getColorTextOfSmallButton(
                    themeProvider,
                    isSelected,
                  ),
                ),
              )
            : Image.asset(icon!),
      ),
    );
  }
}
