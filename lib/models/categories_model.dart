import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CategoriesModel {
  String id;
  String title;
  Icon icon;
  String image;

  CategoriesModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.image,
  });

  static List<CategoriesModel> categoriesWithAll(BuildContext context) {
    return [
      CategoriesModel(
        id: '0',
        title: AppLocalizations.of(context)!.all,
        icon: Icon(Icons.grid_view_rounded),
        image: ImageManager.birthDay,
      ),
      CategoriesModel(
        id: '1',
        title: AppLocalizations.of(context)!.sport,
        icon: Icon(Icons.sports_baseball_outlined),
        image: '',
      ),
      CategoriesModel(
        id: '2',
        title: AppLocalizations.of(context)!.bookClub,
        icon: Icon(Icons.menu_book_outlined),
        image: '',
      ),
      CategoriesModel(
        id: '3',
        title: AppLocalizations.of(context)!.birthday,
        icon: Icon(Icons.celebration_rounded),
        image: '',
      ),
      CategoriesModel(
        id: '4',
        title: AppLocalizations.of(context)!.meeting,
        icon: Icon(Icons.laptop_chromebook),
        image: '',
      ),
      CategoriesModel(
        id: '5',
        title: AppLocalizations.of(context)!.exhibition,
        icon: Icon(Icons.museum_outlined),
        image: '',
      ),
    ];
  }

  static List<CategoriesModel> categoriesWithoutAll(BuildContext context) {
    return [
      CategoriesModel(
        id: '0',
        title: 'Sports',
        icon: Icon(Icons.sports_baseball_outlined),
        image: '',
      ),
      CategoriesModel(
        id: '1',
        title: 'Book Club',
        icon: Icon(Icons.menu_book_outlined),
        image: '',
      ),
      CategoriesModel(
        id: '2',
        title: 'BirthDay',
        icon: Icon(Icons.celebration_rounded),
        image: '',
      ),
      CategoriesModel(
        id: '3',
        title: 'Meeting',
        icon: Icon(Icons.laptop_chromebook),
        image: '',
      ),
      CategoriesModel(
        id: '4',
        title: 'Exhibition',
        icon: Icon(Icons.museum_outlined),
        image: '',
      ),
    ];
  }
}
