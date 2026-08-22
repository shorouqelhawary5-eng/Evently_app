import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.categories,
    required this.selectedTabColor,
    required this.selectedTitleColor,
    required this.selectedIcon,
    required this.unSelectedTabColor,
    required this.unSelectedTitleColor,

    required this.unSelectedIcon,
    this.isSelected = false,
  });
  final CategoriesModel categories;
  final Color selectedTabColor;
  final Color unSelectedTabColor;
  final Color selectedTitleColor;
  final Color unSelectedTitleColor;
  final Color selectedIcon;
  final Color unSelectedIcon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? ColorsManager.blue : ColorsManager.whitePure,
        border: BoxBorder.all(
          color: isSelected ? ColorsManager.blue : ColorsManager.gray,
        ),
      ),
      child: Row(
        children: [
          Icon(
            categories.icon.icon,
            color: isSelected ? ColorsManager.whitePure : ColorsManager.blue,
          ),
          SizedBox(width: 8.w),
          Text(
            categories.title,
            style: TextStyle(
              color: isSelected ? ColorsManager.whitePure : ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
