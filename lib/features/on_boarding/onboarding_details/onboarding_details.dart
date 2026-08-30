import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/features/on_boarding/widgets/onboarding_item.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/onboarding_model.dart';
import 'package:evently_app/prefs_manager/prefs_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnBoardingDetailsScreen extends StatefulWidget {
  const OnBoardingDetailsScreen({super.key});

  @override
  State<OnBoardingDetailsScreen> createState() =>
      _OnBoardingDetailsScreenState();
}

class _OnBoardingDetailsScreenState extends State<OnBoardingDetailsScreen> {
  final PageController _pageController = PageController();
  final List<OnBoardingModel> onBoardingList = OnBoardingModel.onBoardingList;
  int _currentIndex = 0;

  bool get isLastPage => _currentIndex == onBoardingList.length - 1;
  bool get showSkipButton => _currentIndex < 2;

  void _goToNextPage() async {
    if (isLastPage) {
      await PrefsManager.setOnBoardingCompleted(true);
      _navigateAfterOnBoarding();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateAfterOnBoarding() {
    final nextRoute = FirebaseAuth.instance.currentUser == null
        ? RoutesManager.login
        : RoutesManager.home;

    Navigator.pushNamedAndRemoveUntil(context, nextRoute, (route) => false);
  }

  void _skipOnboarding() async {
    await PrefsManager.setOnBoardingCompleted(true);
    if (!mounted) return;
    _navigateAfterOnBoarding();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImageManager.logo),
        automaticallyImplyLeading: false,
        leading: _currentIndex > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goToPreviousPage,
              )
            : null,
        actions: showSkipButton
            ? [
                TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: ColorsManager.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItem(
                    model: onBoardingList[index],
                    index: index,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: onBoardingList.length,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onBoardingList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? ColorsManager.blue
                        : ColorsManager.blue.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButtonWidget(
              buttonColor: ColorsManager.blue,
              buttonTextColor: ColorsManager.whiteFF,
              buttonText: isLastPage
                  ? AppLocalizations.of(context)!.getStarted
                  : AppLocalizations.of(context)!.next,
              onClick: _goToNextPage,
            ),
          ],
        ),
      ),
    );
  }
}
