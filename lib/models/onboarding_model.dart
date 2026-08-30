import 'package:evently_app/core/resources/assets_manager.dart';

class OnBoardingModel {
  String id;
  String title;
  String description;
  String image;

  OnBoardingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OnBoardingModel> get onBoardingList => [
    OnBoardingModel(
      id: '0',
      title: 'Find Events That Inspire You',
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
      image: ImageManager.onBoarding1,
    ),
    OnBoardingModel(
      id: '1',
      title: 'Effortless Event Planning',
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
      image: ImageManager.onBoarding2,
    ),
    OnBoardingModel(
      id: '2',
      title: 'Connect with Friends & Share Moments',
      description:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
      image: ImageManager.onBoarding3,
    ),
  ];
}
