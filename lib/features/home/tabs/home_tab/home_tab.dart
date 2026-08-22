import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/tab_controller_widget.dart';
import 'package:evently_app/features/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/provider/language_provider.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var langProvider = Provider.of<LanguageProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.welcomeBack,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  ),
                ),

                Spacer(),
                InkWell(
                  child: (themeProvider.currentTheme == ThemeMode.light)
                      ? Icon(Icons.wb_sunny_outlined)
                      : Icon(Icons.nightlight_outlined),
                  onTap: () {
                    bool isDark = themeProvider.currentTheme == ThemeMode.light;

                    themeProvider.updateTheme(
                      isDark ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsManager.blue,
                  ),

                  child: InkWell(
                    child: Text(
                      langProvider.currentLang == "en" ? "EN" : "ع",
                      style: TextStyle(
                        color: ColorsManager.whitePure,
                        fontSize: 14,
                        fontWeight: .w600,
                      ),
                    ),
                    onTap: () {
                      bool isEnglish = langProvider.currentLang == "en";
                      langProvider.updateLang(isEnglish ? "ar" : "en");
                    },
                  ),
                ),
              ],
            ),

            Text(
              'Shorouq El-Hawary',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            SizedBox(height: 24.h),

            TabControllerWidget(
              categoriesListName: CategoriesModel.categoriesWithAll(context),
            ),

            SizedBox(height: 24.h),

            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem(
                    event: EventModel(
                      id: '0',
                      title: 'This is a Birthday Party',
                      describtion: '',
                      category: CategoriesModel.categoriesWithAll(context)[0],
                      date: DateTime(2026, 8, 15),
                      time: TimeOfDay(hour: 7, minute: 30),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
