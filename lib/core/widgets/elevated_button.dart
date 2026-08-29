import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor,
    this.icon,
    this.onClick,
  });

  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Widget? icon;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).elevatedButtonTheme.style;

    final buttonStyle = baseStyle?.copyWith(
      backgroundColor: buttonColor != null
          ? WidgetStatePropertyAll(buttonColor)
          : null,
      foregroundColor: buttonTextColor != null
          ? WidgetStatePropertyAll(buttonTextColor)
          : null,
    );

    return ElevatedButton(
      onPressed: onClick,
      style: buttonStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null) SizedBox(width: 10.w),
          Text(buttonText),
        ],
      ),
    );
  }
}
