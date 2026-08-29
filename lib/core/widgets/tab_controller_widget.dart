import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/tab_item.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TabControllerWidget extends StatefulWidget {
  const TabControllerWidget({
    super.key,
    required this.categoriesListName,
    this.onClickCategory,
  });
  final List<CategoriesModel> categoriesListName;
  final void Function(CategoriesModel)? onClickCategory;

  @override
  State<TabControllerWidget> createState() => _TabControllerWidgetState();
}

class _TabControllerWidgetState extends State<TabControllerWidget> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categoriesListName.length,

      child: TabBar(
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
            widget.onClickCategory?.call(
              widget.categoriesListName[currentTabIndex],
            );
          });
        },
        labelStyle: TextStyle(fontSize: 16.sp, fontWeight: .w500),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,

        tabs: widget.categoriesListName
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
                    (widget.categoriesListName.indexOf(category) ==
                    currentTabIndex),
              ),
            )
            .toList(),
      ),
    );
  }
}
