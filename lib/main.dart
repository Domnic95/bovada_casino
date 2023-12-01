import 'package:bavada_casino/routs/routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// API ANDROID => AIzaSyASQFm43xKEo08vB3TzM1eit32AaiIDQto


late Size size;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bavada Casino',
      debugShowCheckedModeBanner: false,
      initialRoute: Routs.splashScreen,
      getPages: getPages,
    );
  }
}
