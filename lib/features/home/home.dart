import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/features/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently_app/features/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/features/home/tabs/profile_tab/profilr_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> theTabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: theTabs[_currentIndex],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      selectedFontSize: 12,

      unselectedFontSize: 12,

      currentIndex: _currentIndex,

      onTap: _onTab,

      items: [
        BottomNavigationBarItem(
          icon: (_currentIndex == 0)
              ? Image.asset(IconManager.homeSelsected)
              : Image.asset(IconManager.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: (_currentIndex == 1)
              ? Image.asset(IconManager.favoriteSelected)
              : Image.asset(IconManager.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: (_currentIndex == 2)
              ? Image.asset(IconManager.profileSelected)
              : Image.asset(IconManager.profile),
          label: 'Profile',
        ),
      ],
    );
  }

  void _onTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
