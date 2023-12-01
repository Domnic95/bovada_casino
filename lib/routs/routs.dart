import 'package:bavada_casino/screen/home_screen.dart';
import 'package:bavada_casino/screen/navigation_screen.dart';
import 'package:bavada_casino/screen/splash_screen.dart';
import 'package:get/get.dart';

class Routs {
  static String splashScreen = "/splash";
  static String homeScreen = "/home";
  static String navigationScreen = "/navigation";
}

final getPages = [
  GetPage(name: Routs.splashScreen, page: () => const SplashScreen()),
  GetPage(name: Routs.homeScreen, page: () => const HomeScreen()),
  GetPage(name: Routs.navigationScreen, page: () => const NavigationScreen()),
];
