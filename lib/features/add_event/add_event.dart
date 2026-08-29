import 'package:evently_app/core/dialogUtils/dialog_utils.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/tab_controller_widget.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key, this.event});
  final EventModel? event;

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDateTime;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  CategoriesModel? selectedCategory;

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      _selectedDateTime = widget.event!.dateAndTime;
      _titleController = TextEditingController(text: widget.event!.title);
      _descriptionController = TextEditingController(
        text: widget.event!.description,
      );
      selectedCategory = widget.event!.category;
    } else {
      _selectedDateTime = DateTime.now();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (selectedCategory == null && widget.event == null) {
      selectedCategory = CategoriesModel.categoriesWithoutAll(context)[0];
    }
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
      appBar: AppBar(
        title: widget.event == null
            ? Text(localizations.addEvent)
            : Text(localizations.editEvent),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(right: 16.w, left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (selectedCategory != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(selectedCategory!.image),
                ),

              SizedBox(height: 12.h),

              TabControllerWidget(
                categoriesListName: CategoriesModel.categoriesWithoutAll(
                  context,
                ),
                onClickCategory: (newCategory) {
                  setState(() {
                    selectedCategory = newCategory;
                  });
                },
              ),

              SizedBox(height: 10.h),

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

              ElevatedButtonWidget(
                buttonText: widget.event == null
                    ? localizations.addEvent
                    : localizations.updateEvent,
                onClick: _saveEvent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEvent() async {
    if (selectedCategory == null) return;

    EventModel event = EventModel(
      ownerId: FirebaseAuth.instance.currentUser!.uid,
      id: widget.event?.id ?? "",
      title: _titleController.text,
      description: _descriptionController.text,
      category: selectedCategory!,
      dateAndTime: _selectedDateTime,
    );
    DialogUtils.showLoading(context, false);

    if (widget.event == null) {
      await FirebaseServices.addEventToFirebase(event, context);
    } else {
      await FirebaseServices.editEvent(event, context);
    }

    if (mounted) {
      DialogUtils.hideShowDialog(context);
      DialogUtils.showToastMessage(
        widget.event == null
            ? "Event added successfully"
            : "Event updated successfully",
        ColorsManager.green,
      );
      Navigator.pop(context);
    }
  }
}
