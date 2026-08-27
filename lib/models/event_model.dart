import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  String ownerId;
  String id;
  String title;
  String description;
  CategoriesModel category;
  DateTime dateAndTime;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dateAndTime,
    required this.ownerId,
  });

  EventModel.fromJson(Map<String, dynamic> json, BuildContext context)
    : this(
        ownerId: json["ownerId"],
        id: json["id"],
        title: json["title"],
        description: json["description"],
        category: CategoriesModel.categoriesWithAll(
          context,
        ).firstWhere((category) => category.id == json["categoryId"]),
        dateAndTime:
            (json["dateAndTime"] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "categoryId": category.id,
    "dateAndTime": dateAndTime,
    "ownerId": ownerId,
  };
}
