import 'package:evently_app/core/dialogUtils/dialog_utils.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/tab_controller_widget.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDateTime;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late CategoriesModel selectedCategory = CategoriesModel.categoriesWithoutAll(
    context,
  )[0];

  @override
  void initState() {
    super.initState();

    _selectedDateTime = DateTime.now();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour < 12 ? 'AM' : 'PM';

    return '$hourString:$minuteString $period';
  }

  TextDirection _getTextDirection(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final textDirection = _getTextDirection(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations.addEvent)),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(right: 16.w, left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageManager.birthDay),

              SizedBox(height: 4.h),

              TabControllerWidget(
                categoriesListName: CategoriesModel.categoriesWithoutAll(
                  context,
                ),
                onClickCategory: (newCategory) {
                  selectedCategory = newCategory;
                },
              ),

              SizedBox(height: 10.h),

              // Title
              Text(
                localizations.title,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                textAlign: TextAlign.start,
              ),

              SizedBox(height: 4.h),

              CustomTextFromField(
                controller: _titleController,
                hintText: localizations.eventTitle,
              ),

              SizedBox(height: 10.h),

              // Description
              Text(
                localizations.description,
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              SizedBox(height: 4.h),

              CustomTextFromField(
                controller: _descriptionController,
                hintText: localizations.eventDescription,
                maxLines: 4,
              ),

              SizedBox(height: 16.h),

              // Date
              Directionality(
                textDirection: textDirection,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),

                    SizedBox(width: 4.w),

                    Text(
                      _formatDate(_selectedDateTime),
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    const Spacer(),

                    TextButtonWidget(
                      buttonText: localizations.chooseDate,
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );

                        if (picked != null) {
                          setState(() {
                            _selectedDateTime = DateTime(
                              picked.year,
                              picked.month,
                              picked.day,
                              _selectedDateTime.hour,
                              _selectedDateTime.minute,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5.h),

              // Time
              Directionality(
                textDirection: textDirection,
                child: Row(
                  children: [
                    const Icon(Icons.more_time_outlined),

                    SizedBox(width: 4.w),

                    Text(
                      _formatTime(_selectedDateTime),
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),

                    const Spacer(),

                    TextButtonWidget(
                      buttonText: localizations.chooseTime,
                      onPressed: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: _selectedDateTime.hour,
                            minute: _selectedDateTime.minute,
                          ),
                        );

                        if (picked != null) {
                          setState(() {
                            _selectedDateTime = DateTime(
                              _selectedDateTime.year,
                              _selectedDateTime.month,
                              _selectedDateTime.day,
                              picked.hour,
                              picked.minute,
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              ElevatedButtonWidget(buttonText: "Add Event", onClick: _addEvent),
            ],
          ),
        ),
      ),
    );
  }

  void _addEvent() async {
    EventModel event = EventModel(
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      id: "",
      title: _titleController.text,
      description: _descriptionController.text,
      category: selectedCategory,
      dateAndTime: _selectedDateTime,
    );
    DialogUtils.showLoading(context, false);
    await FirebaseServices.addEventToFirebase(event, context);
    DialogUtils.hideShowDialog(context);
    DialogUtils.showToastMessage("Event add succesfully", ColorsManager.green);
    Navigator.pop(context);
  }
}
