import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:learnlyapp/constants/colors.dart';
import 'package:learnlyapp/constants/dimensions.dart';
import 'package:learnlyapp/features/home/ui/home_screen.dart';
import 'package:learnlyapp/features/dashboard/ui/dashboard_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTab = 0;

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  final List _pages = const [
    HomeScreen(),
    DashboardScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: _pages[_selectedTab],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes the shadow direction
            ),
          ],
        ),
        margin: EdgeInsets.only(
          bottom: getScreenWidth(context) * 0.05,
          left: getScreenWidth(context) * 0.15,
          right: getScreenWidth(context) * 0.15,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: pinkColor),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),

            backgroundColor: whiteColor,
            currentIndex: _selectedTab,
            onTap: (index) {
              _changeTab(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user),
                label: 'Dashboard',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
