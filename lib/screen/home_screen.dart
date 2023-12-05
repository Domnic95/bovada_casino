import 'package:bavada_casino/const/color_const.dart';
import 'package:bavada_casino/controller/location_controller.dart';
import 'package:bavada_casino/screen/banner_screen.dart';
import 'package:bavada_casino/screen/location_screen.dart';
import 'package:bavada_casino/screen/navigation_screen.dart';
import 'package:bavada_casino/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const BannerScreen(),
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
  void initState() {
    final cont = Get.put(LocationController());
    cont.getLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: Colors.black45,
          unselectedLabelStyle: const TextStyle(color: Colors.black45),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: selectedIndex,
          onTap: onItemTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: "Home",
            ),
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
