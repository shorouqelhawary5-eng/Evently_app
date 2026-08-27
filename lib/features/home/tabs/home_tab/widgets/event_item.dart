import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventItem extends StatefulWidget {
  const EventItem({super.key, required this.event, this.onFavoriteChanged});
  final EventModel event;
  final ValueChanged<bool>? onFavoriteChanged;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite =
        UserModel.currentUser?.favoriteEventId.contains(widget.event.id) ??
        false;
  }

  Future<void> _toggleFavorite() async {
    if (UserModel.currentUser == null) {
      return;
    }

    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      if (isFavorite) {
        await FirebaseServices.addEventtoFavorite(widget.event);
      } else {
        await FirebaseServices.removeEventFromFavourite(widget.event);
      }
      widget.onFavoriteChanged?.call(isFavorite);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isFavorite = !isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.event.category.image),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.gray),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 8.w, left: 8, top: 4.h, bottom: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              // color: ColorsManager.whiteFF,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('dd MMM').format(widget.event.dateAndTime),
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),

                // ),
              ),
            ),

            SizedBox(height: 80.h),
            Card(
              // color:ColorsManager.whiteFF,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
