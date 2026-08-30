import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ThemeManager {
  static ButtonStyle elevatedButtonStyleLight({
    Color? buttonColor,
    Color? textColor,
  }) {
    final backgroundColor = buttonColor ?? ColorsManager.blue;
    final foregroundColor = textColor ?? ColorsManager.whiteFF;

    return ElevatedButton.styleFrom(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  static ButtonStyle elevatedButtonStyleDark({
    Color? buttonColor,
    Color? textColor,
  }) {
    final backgroundColor = buttonColor ?? const Color(0xFF0E3A99);
    final foregroundColor = textColor ?? ColorsManager.inputsDark;

    return ElevatedButton.styleFrom(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  static final ThemeData lightTheme = ThemeData(
    cardTheme: CardThemeData(color: ColorsManager.whiteF0),
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsManager.whiteFF,
    iconTheme: IconThemeData(color: ColorsManager.blue),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: .w500,
        color: ColorsManager.black,
      ),
      iconTheme: IconThemeData(color: ColorsManager.blue),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.whitePure,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.darkGray,
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
      bodyLarge: TextStyle(color: ColorsManager.black),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.blue,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkGray,
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

      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.whiteFF,
      ),

      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkGray,
      ),
      labelLarge: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),

      labelSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyleLight(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.whitePure,
      shape: CircleBorder(),
      extendedPadding: EdgeInsetsDirectional.only(bottom: 16),
    ),

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

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsManager.backGroundDarkMode,
    iconTheme: IconThemeData(color: ColorsManager.blue8F),

    cardTheme: CardThemeData(color: ColorsManager.inputsDark),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: .w500,
        color: ColorsManager.whitePure,
      ),

      iconTheme: IconThemeData(color: ColorsManager.whiteFF),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.inputsDark,
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.gray6D,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue8F),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue8F),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue8F),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorsManager.gray6D),
      headlineLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.whiteFF,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.whiteFF,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkGray,
      ),
      titleLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.whiteFF,
      ),

      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.whiteFF,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.whiteFF,
      ),

      labelMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkGray,
      ),
      labelLarge: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blueED,
      ),
      labelSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.whiteFF,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyleDark(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blueED,
      foregroundColor: ColorsManager.whiteFF,
      shape: CircleBorder(),
      extendedPadding: EdgeInsetsDirectional.only(bottom: 16),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        foregroundColor: ColorsManager.blueED,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.backGroundDarkMode,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorsManager.gray,
    ),
  );
}
