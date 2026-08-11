import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ThemeManager {
  static ButtonStyle elevatedButtonStyle({
    Color? buttonColor,
    Color? textColor,
  }) {
    return ElevatedButton.styleFrom(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      backgroundColor: buttonColor ?? ColorsManager.blue,
      foregroundColor: textColor ?? ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFF0F0F0),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.dark_gray,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.gray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.gray),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.blue,
      ),

      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),

      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.black,
      ),

      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.dark_gray,
      ),
      labelLarge: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle()),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        foregroundColor: ColorsManager.blue,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.whitePure,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorsManager.gray,
    ),
  );

  static final ThemeData darkTheme = ThemeData();
}
