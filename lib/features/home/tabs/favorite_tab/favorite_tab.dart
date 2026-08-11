import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/features/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextFromField(
              hintText: 'Search for event',
              suffixIcon: Icon(Icons.search),
            ),

            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return EventItem(
                    event: EventModel(
                      id: '0',
                      title: 'This is a Birthday Party',
                      describtion: '',
                      category: CategoriesModel.categories[0],
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
