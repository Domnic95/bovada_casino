import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff2E0327),
          title: const Text(
            "Contact Us",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          // backgroundColor: AppColors.backgroundColor,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    if (!await launchUrlString("bovada@help.com")) {
                      throw Exception('Could not launch');
                    }
                  },
                  child: const Text(
                    "bovada@help.com",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
