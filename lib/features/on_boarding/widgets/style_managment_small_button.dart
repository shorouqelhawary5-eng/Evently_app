import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';

class StyleManagmentSmallButton {
  static Color getColorBackgroundOfSmallButton(
    ThemeProvider theme,
    bool isSelected,
  ) {
    if (theme.currentTheme == ThemeMode.light) {
      if (isSelected) {
        return ColorsManager.blue;
      } else {
        return ColorsManager.whiteFF;
      }
    } else {
      if (isSelected) {
        return ColorsManager.blueED;
      } else {
        return ColorsManager.inputsDark;
      }
    }
  }

  static Color getColorTextOfSmallButton(ThemeProvider theme, bool isSelected) {
    if (theme.currentTheme == ThemeMode.light) {
      if (isSelected) {
        return ColorsManager.whiteFF;
      } else {
        return ColorsManager.blue;
      }
    } else {
      return ColorsManager.whiteFF;
    }
  }

  static String getIconOfSmallButtonSun(ThemeProvider theme, bool isSelected) {
    if (theme.currentTheme == ThemeMode.light) {
      if (isSelected) {
        return IconManager.sunLight;
      } else {
        return IconManager.sunUnselecte;
      }
    } else {
      return IconManager.sunDark;
    }
  }

  static String getIconOfSmallButtonMoon(ThemeProvider theme, bool isSelected) {
    if (theme.currentTheme == ThemeMode.light) {
      if (isSelected) {
        return IconManager.moonDark;
      } else {
        return IconManager.moonLight;
      }
    } else {
      return IconManager.moonDark;
    }
  }
}
