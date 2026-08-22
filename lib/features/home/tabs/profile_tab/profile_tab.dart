import 'package:evently_app/config/theme/theme.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/language_provider.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImageManager.profile),
            SizedBox(height: 16.h),
            Text(
              'Shorouq El-Hawary',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: 4.h),

            Text(
              'shorouq@gmail.com',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),

            SizedBox(height: 32.h),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorsManager.gray),
              ),
              child: Padding(
                padding: REdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.darkMode,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    Spacer(),

                    Switch(
                      value: themeProvider.currentTheme == ThemeMode.dark,
                      onChanged: (isDarkEnable) {
                        themeProvider.updateTheme(
                          isDarkEnable ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorsManager.gray),
              ),
              child: Padding(
                padding: REdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    Spacer(),

                    PopupMenuButton<String>(
                      icon: Icon(Icons.language),

                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'en',
                          child: Text('English'),
                        ),
                        const PopupMenuItem(
                          value: 'ar',
                          child: Text('العربية'),
                        ),
                      ],
                      onSelected: (selectedLang) {
                        languageProvider.updateLang(selectedLang);
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            InkWell(
              onTap: _logOut,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorsManager.gray),
                ),
                child: Padding(
                  padding: REdgeInsets.all(8),
                  child: Padding(
                    padding: REdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.logout,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        Spacer(),

                        Icon(Icons.logout, color: ColorsManager.red),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }
}
