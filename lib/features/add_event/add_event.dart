import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/tab_controller_widget.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    // Initialize with sensible defaults so values are never null unintentionally
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  String _formatTime(TimeOfDay t) {
    final h = t.hourOfPeriod == 0 && t.period == DayPeriod.pm
        ? 12
        : t.hourOfPeriod;
    final hour = (h == 0)
        ? 12
        : h; // convert 0 -> 12 for 12-hour style display when needed
    final hh = hour.toString().padLeft(2, '0');
    final mm = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hh:$mm $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(right: 16.w, left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageManager.birthDay),
              SizedBox(height: 16.h),
              TabControllerWidget(
                categoriesListName: CategoriesModel.categoriesWithoutAll(
                  context,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'title',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 8.h),
              const CustomTextFromField(hintText: 'Event Title'),

              SizedBox(height: 16.h),
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 8.h),
              const CustomTextFromField(
                hintText: 'Event Description....',
                maxLines: 4,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  SizedBox(width: 4.w),
                  Text(
                    _selectedDate != null
                        ? _formatDate(_selectedDate!)
                        : 'Event Date',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  TextButtonWidget(
                    buttonText: 'Choose date',
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      // Only update state if the user actually picked a date (didn't cancel)
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  const Icon(Icons.more_time_outlined),

                  SizedBox(width: 4.w),
                  Text(
                    _selectedTime != null
                        ? _formatTime(_selectedTime!)
                        : 'Event Time',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  const Spacer(),
                  TextButtonWidget(
                    buttonText: 'Choose time',
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime ?? TimeOfDay.now(),
                      );

                      // Only update state if the user actually picked a time (didn't cancel)
                      if (picked != null) {
                        setState(() {
                          _selectedTime = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
