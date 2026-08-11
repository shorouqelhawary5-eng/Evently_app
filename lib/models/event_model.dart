import 'package:evently_app/models/categories_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  final String id;
  final String title;
  final String describtion;
  final CategoriesModel category;
  final TimeOfDay time;
  final DateTime date;

  EventModel({
    required this.id,
    required this.title,
    required this.describtion,
    required this.category,
    required this.date,
    required this.time,
  });
}
