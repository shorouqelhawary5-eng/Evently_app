import 'package:evently_app/core/resources/assets_manager.dart';
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

  static List<CategoriesModel> categories = [
    CategoriesModel(
      id: '0',
      title: 'All',
      icon: Icon(Icons.grid_view_rounded),
      image: ImageManager.birthDay,
    ),
    CategoriesModel(
      id: '1',
      title: 'Sports',
      icon: Icon(Icons.sports_baseball_outlined),
      image: '',
    ),
    CategoriesModel(
      id: '2',
      title: 'Book Club',
      icon: Icon(Icons.menu_book_outlined),
      image: '',
    ),
    CategoriesModel(
      id: '3',
      title: 'BirthDay',
      icon: Icon(Icons.celebration_rounded),
      image: '',
    ),
    CategoriesModel(
      id: '4',
      title: 'Meeting',
      icon: Icon(Icons.laptop_chromebook),
      image: '',
    ),
    CategoriesModel(
      id: '5',
      title: 'Exhibition',
      icon: Icon(Icons.museum_outlined),
      image: '',
    ),
  ];
}
