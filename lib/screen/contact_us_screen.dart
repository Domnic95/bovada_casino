import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

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
          centerTitle: true,
          title: const Text(
            "Contact Us",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: bodyData(),
      ),
    );
  }

  Widget bodyData() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          listTileConst(
              icon: Icons.email_sharp,
              title: "Email us:",
              subTitle: "help@bovadaltd.com"),
          listTileConst(
              icon: Icons.phone,
              title: "Contact Us:",
              subTitle: "(888) 263-0000"),
          listTileConst(
              icon: Icons.location_on,
              title: "Address:",
              subTitle: "12/A Kingfisher RoadMedino Washington, NY 10012, USA"),
        ],
      ),
    );
  }

  Widget listTileConst({IconData? icon, title, subTitle}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(icon),
          ),
          title: Text(
            title,
            style: const TextStyle(
                // color: Appcolor.secondarycolor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                wordSpacing: 1),
          ),
          subtitle: Text(
            subTitle,
            style: const TextStyle(
                // color: Appcolor.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                wordSpacing: 1),
          ),
        ),
      ),
    );
  }
}
