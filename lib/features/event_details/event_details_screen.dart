import 'package:evently_app/core/dialogUtils/dialog_utils.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/features/event_details/widgets/icons_style_in_appbar.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/provider/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventModel;
    var themeProvider = Provider.of<ThemeProvider>(context);

    final isDarkTheme = themeProvider.currentTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(AppLocalizations.of(context)!.eventDetails),
        actions: (FirebaseAuth.instance.currentUser!.uid == event.ownerId)
            ? [
                IconsAppBar(icon: Image.asset(IconManager.edit)),
                SizedBox(width: 6.w),

                InkWell(
                  onTap: () => _deleteEvent(event, context),
                  child: IconsAppBar(icon: Image.asset(IconManager.delete)),
                ),
              ]
            : null,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  event.category.image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                event.title,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDarkTheme == ThemeMode.dark
                        ? ColorsManager.blue8F
                        : ColorsManager.gray,
                  ),
                  color: isDarkTheme == ThemeMode.dark
                      ? ColorsManager.inputsDark
                      : ColorsManager.whiteFF,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      color: ColorsManager.blue,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM').format(event.dateAndTime),
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(event.dateAndTime),
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                AppLocalizations.of(context)!.description,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: REdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDarkTheme == ThemeMode.dark
                        ? ColorsManager.blue8F
                        : ColorsManager.gray,
                  ),
                  color: isDarkTheme == ThemeMode.dark
                      ? ColorsManager.inputsDark
                      : ColorsManager.whiteFF,
                ),
                child: Text(
                  event.description,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteEvent(EventModel event, BuildContext context) {
    FirebaseServices.deleteEvent(event, context);
    DialogUtils.showToastMessage(
      "delete event Sucssesfully",
      ColorsManager.green,
    );
    Navigator.pop(context);
  }
}
