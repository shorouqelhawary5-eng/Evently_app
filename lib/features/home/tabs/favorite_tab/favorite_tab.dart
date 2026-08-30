import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/features/home/tabs/home_tab/widgets/event_item.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late Future<List<EventModel>> favoriteEventsFuture;

  @override
  void initState() {
    super.initState();
    favoriteEventsFuture = FirebaseServices.getFavoriteEventsFromFirebase(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextFromField(
              hintText: AppLocalizations.of(context)!.searchForEvent,
              suffixIcon: Icon(Icons.search),
            ),

            SizedBox(height: 16.h),
            Expanded(
              child: FutureBuilder<List<EventModel>>(
                future: favoriteEventsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  final favoriteEvents = snapshot.data ?? [];
                  if (favoriteEvents.isEmpty) {
                    return const Center(child: Text('No favorite events'));
                  }

                  return ListView.separated(
                    itemCount: favoriteEvents.length,
                    itemBuilder: (context, index) {
                      final event = favoriteEvents[index];
                      return EventItem(
                        event: event,
                        onFavoriteChanged: (isFavorite) {
                          if (!isFavorite && mounted) {
                            setState(() {
                              favoriteEvents.removeWhere(
                                (favoriteEvent) => favoriteEvent.id == event.id,
                              );
                            });
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
