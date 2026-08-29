// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/features/add_event/add_event.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/categories_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddEvent shows edit mode when an event is provided', (
    WidgetTester tester,
  ) async {
    final event = EventModel(
      ownerId: 'user-1',
      id: 'event-1',
      title: 'Team meeting',
      description: 'Discuss launch timeline',
      category: CategoriesModel(
        id: '3',
        title: 'Meeting',
        icon: const Icon(Icons.laptop_chromebook),
        image: ImageManager.meeting,
      ),
      dateAndTime: DateTime(2026, 8, 29, 18, 30),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ar')],
        home: AddEvent(event: event),
      ),
    );

    expect(find.text('Edit Event'), findsOneWidget);
    expect(find.text('Update event'), findsOneWidget);
    expect(find.text('Team meeting'), findsOneWidget);
    expect(find.text('Discuss launch timeline'), findsOneWidget);
  });
}
