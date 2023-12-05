import 'dart:async';
import 'package:bavada_casino/main.dart';
import 'package:bavada_casino/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => Get.off(const HomeScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff350B2D),
      body: Center(
        child: Image.asset(
          "assets/images/icon.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
