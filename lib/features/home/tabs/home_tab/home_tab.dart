import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/tab_item.dart';
import 'package:evently_app/features/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome Back ✨',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  ),
                ),

                Spacer(),
                Icon(Icons.wb_sunny_outlined),
                SizedBox(width: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorsManager.blue,
                  ),

                  child: Text(
                    'EN',
                    style: TextStyle(
                      color: ColorsManager.whitePure,
                      fontSize: 14,
                      fontWeight: .w600,
                    ),
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

            DefaultTabController(
              length: CategoriesModel.categories.length,

              child: TabBar(
                onTap: (index) {
                  setState(() {
                    currentTabIndex = index;
                  });
                },
                labelStyle: TextStyle(fontSize: 16.sp, fontWeight: .w500),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,

                tabs: CategoriesModel.categories
                    .map(
                      (category) => TabItem(
                        categories: category,
                        selectedTabColor: ColorsManager.blue,
                        selectedTitleColor: ColorsManager.whitePure,
                        selectedIcon: ColorsManager.whitePure,
                        unSelectedTabColor: ColorsManager.whitePure,
                        unSelectedTitleColor: ColorsManager.black,
                        unSelectedIcon: ColorsManager.blue,
                        isSelected:
                            (CategoriesModel.categories.indexOf(category) ==
                            currentTabIndex),
                      ),
                    )
                    .toList(),
              ),
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
