import 'package:evently_app/config/theme/theme.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/language_provider.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:evently_app/provider/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:provider/provider.dart';
import 'core/routes_manager/routes_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    as flutter_localizations;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   final themeProvider = ThemeProvider();
//   await themeProvider.getSavedTheme();
//   final langProvider = LanguageProvider();
//   await langProvider.getLang();
//   final userProvider = UserProvider();

//   final currentUser = FirebaseAuth.instance.currentUser;

//   if (currentUser != null) {
//     final userData = await FirebaseServices.getUserFromFirebase(
//       currentUser.uid,
//     );

//     if (userData != null) {
//       userProvider.updateUserData(userData);
//     }
//   }
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
//         ChangeNotifierProvider<LanguageProvider>.value(value: langProvider),
//         ChangeNotifierProvider<UserProvider>.value(value: userProvider),
//       ],
//       child: EventlyApp(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final themeProvider = ThemeProvider();
  await themeProvider.getSavedTheme();
  final langProvider = LanguageProvider();
  await langProvider.getLang();
  final userProvider = UserProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<LanguageProvider>.value(value: langProvider),
        ChangeNotifierProvider<UserProvider>.value(value: userProvider),
      ],
      child: const EventlyApp(),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ScreenUtilPlusInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesManager.splash,
          onGenerateRoute: RoutesManager.generateRoute,
          theme: ThemeManager.lightTheme,
          darkTheme: ThemeManager.darkTheme,
          themeMode: themeProvider.currentTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            flutter_localizations.GlobalMaterialLocalizations.delegate,
            flutter_localizations.GlobalWidgetsLocalizations.delegate,
            flutter_localizations.GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale("en"), Locale("ar")],
          locale: Locale(languageProvider.currentLang),
        );
      },
    );
  }
}
