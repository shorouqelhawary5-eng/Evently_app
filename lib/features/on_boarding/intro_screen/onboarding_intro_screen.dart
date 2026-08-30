import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/features/on_boarding/widgets/small_button.dart';
import 'package:evently_app/features/on_boarding/widgets/style_managment_small_button.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/language_provider.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';

class OnBoardingIntroScreen extends StatelessWidget {
  const OnBoardingIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 27.h, child: Image.asset(ImageManager.logo)),
              SizedBox(height: 10.h),
              Image.asset(ImageManager.onBoardingIntro),
              SizedBox(height: 24.h),
              Text(
                localizations.onBoardingIntroTitle,
                style: theme.textTheme.headlineMedium,
              ),
              SizedBox(height: 16.h),
              Text(
                localizations.onBoardingIntroDescribtion,
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.language,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  SmallButton(
                    text: localizations.english,
                    isSelected: languageProvider.currentLang == 'en',
                    onTap: () => languageProvider.updateLang('en'),
                  ),
                  SizedBox(width: 8.w),
                  SmallButton(
                    text: localizations.arab,
                    isSelected: languageProvider.currentLang == 'ar',
                    onTap: () => languageProvider.updateLang('ar'),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      localizations.theme,
                      style: theme.textTheme.labelSmall,
                    ),
                  ),
                  SmallButton(
                    icon: StyleManagmentSmallButton.getIconOfSmallButtonSun(
                      themeProvider,
                      themeProvider.currentTheme == ThemeMode.light,
                    ),
                    isSelected: themeProvider.currentTheme == ThemeMode.light,
                    onTap: () => themeProvider.updateTheme(ThemeMode.light),
                  ),
                  SizedBox(width: 8.w),
                  SmallButton(
                    icon: StyleManagmentSmallButton.getIconOfSmallButtonMoon(
                      themeProvider,
                      themeProvider.currentTheme == ThemeMode.dark,
                    ),
                    isSelected: themeProvider.currentTheme == ThemeMode.dark,
                    onTap: () => themeProvider.updateTheme(ThemeMode.dark),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              ElevatedButtonWidget(
                buttonText: localizations.getStarted,
                buttonColor: themeProvider.currentTheme == ThemeMode.light
                    ? ColorsManager.blue
                    : ColorsManager.blueED,
                buttonTextColor: ColorsManager.whitePure,
                onClick: () => Navigator.pushReplacementNamed(
                  context,
                  RoutesManager.onBoardingDetails,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
