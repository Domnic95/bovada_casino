import 'package:bavada_casino/screen/location_screen.dart';
import 'package:bavada_casino/screen/navigation_screen.dart';
import 'package:bavada_casino/screen/setting_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const LocationScreen(),
    const NavigationScreen(),
    const SettingScreen(),
  ];
  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.my_location,
                size: 20,
              ),
              label: "Location",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.move_down,
                size: 20,
              ),
              label: "Move",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20,
              ),
              label: "Setting",
            ),
          ],
        ),
        body: pages.elementAt(selectedIndex),
      ),
    );
  }
}
