import 'dart:io';
import 'package:bavada_casino/routs/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// API ANDROID => AIzaSyASQFm43xKEo08vB3TzM1eit32AaiIDQto

// DIRECTION KEY = "AIzaSyB8aJIlM_zaMkECxQwr23KPzCZeIYZvfVc";

late Size size;


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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
