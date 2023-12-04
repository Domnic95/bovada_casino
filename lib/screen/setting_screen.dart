import 'package:bavada_casino/screen/contact_us_screen.dart';
import 'package:bavada_casino/screen/privacy_policy_screen.dart';
import 'package:bavada_casino/screen/terms_of_use_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<dynamic> settingData = [
    {
      "icon": Icons.lock_clock_sharp,
      "name": "Privacy Policy",
      "url": "https://bovadaltd.com/policy.html",
      "page": const PrivacyPolicyScreen(),
    },
    {
      "icon": Icons.app_registration,
      "name": "Terms of Use",
      "url": "https://bovadaltd.com/terms-conditions.html",
      "page": const TermsOfUseScreen(),
    },
    {
      "icon": Icons.call_outlined,
      "name": "Contact-Us",
      "url": "https://bovadaltd.com/contact.html",
      "page": const ContactUsScreen(),
    },
    {
      "icon": Icons.add_moderator_sharp,
      "name": "About",
      "url": "https://bovadaltd.com/about.html",
      "page": const Text(""),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xff2E0327),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: settingData.length,
            itemBuilder: (context, index) {
              return listTileConst(index,
                  title: settingData[index]["name"],
                  icon: settingData[index]["icon"],
                  Url: settingData[index]["url"],
                  navigatePage: settingData[index]["page"]);
            },
          )
        ],
      ),
    );
  }

  Widget listTileConst(int index,
      {title, IconData? icon, String? Url, Widget? navigatePage}) {
    return ListTile(
      onTap: () async {
        if (index < 3) {
          Get.to(navigatePage);
        }
        if (index == 3) {
          final Uri url = Uri.parse("$Url");
          if (!await launchUrl(url)) {
            throw Exception('Could not launch $Url');
          }
        }
      },
      horizontalTitleGap: 2,
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: const Icon(
        color: Colors.black,
        Icons.arrow_forward_ios_outlined,
        size: 18,
      ),
      subtitle: const Divider(color: Colors.black),
    );
  }
}
