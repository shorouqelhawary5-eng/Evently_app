import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ThemeManager {
  static ButtonStyle elevatedButtonStyle_light({
    Color? buttonColor,
    Color? textColor,
  }) {
    return ElevatedButton.styleFrom(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      backgroundColor: buttonColor ?? ColorsManager.blue,
      foregroundColor: textColor ?? ColorsManager.whiteFF,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
    );
  }

  static ButtonStyle elevatedButtonStyle_dark({
    Color? buttonColor,
    Color? textColor,
  }) {
    return ElevatedButton.styleFrom(
      padding: REdgeInsets.symmetric(vertical: 8.h),
      backgroundColor: buttonColor ?? ColorsManager.blueED,
      foregroundColor: textColor ?? ColorsManager.inputsDark,
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
        color: ColorsManager.darkGray,
      ),
      labelLarge: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle_light(),
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

    cardTheme: CardThemeData(color: ColorsManager.backGroundDarkMode),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: .w500,
        color: ColorsManager.whitePure,
      ),
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
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: elevatedButtonStyle_dark(),
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
