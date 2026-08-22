import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(event.category.image),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.gray),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 8.w, left: 8, top: 4.h, bottom: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              // color: ColorsManager.whiteFF,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd MMM').format(event.date),
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),

                // ),
              ),
            ),

            SizedBox(height: 88.h),
            Card(
              // color:ColorsManager.whiteFF,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.title,
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: ColorsManager.blue,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
