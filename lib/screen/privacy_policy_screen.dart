import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff2E0327),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          // backgroundColor: AppColors.backgroundColor,
        ),
        body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bovada Privacy Statement",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Introduction",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "Welcome to the Bovada Privacy Statement. Safeguarding the privacy of our users is a fundamental aspect of our mission. This statement provides an overview of the information collected at Bovada and how we handle it. If you have any concerns or require additional information about our privacy practices, please don't hesitate to reach out to us."),
                SizedBox(height: 20),
                Text(
                  "User Interaction Data",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "At Bovada, we follow standard data practices, including the maintenance of log files. These files capture details such as IP addresses, browser types, ISPs, timestamps, referral and exit pages, and, on occasion, the number of clicks when users engage with our app. This data does not identify individual users but assists us in analyzing trends, managing the app, monitoring user behavior, and gathering general demographic information."),
                SizedBox(height: 20),
                Text(
                  "Ad Partners and Their Practices",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "We collaborate with several advertisers who may utilize cookies and web beacons within our app. Below, you'll find a list of our advertising partners along with links to their respective privacy practices for your convenience:"),
                Text(
                    "To gain a deeper understanding of how our advertising partners operate on Bovada, please refer to the linked list above. Please note that these third-party advertisers may employ tools like cookies, JavaScript, or beacons to collect information, including your IP address. These tools aid in measuring the effectiveness of their ads or personalizing the advertisements you encounter, whether on our app or other websites. It's important to clarify that Bovada does not have control over these third-party cookies."),
                SizedBox(height: 20),
                Text(
                  "Guidance on External Privacy Practices",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "Our Privacy Statement does not encompass the practices of other advertisers or websites. For a comprehensive understanding, we recommend reviewing the privacy policies of any third-party services you engage with. This will provide you with insights into their operations and offer options for opting out of certain data collection methods."),
                SizedBox(height: 20),
                Text(
                  "Protecting Young Users",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "One of our foremost commitments is the online safety of minors. We encourage parents and guardians to supervise and guide their children's online activities. Bovada does not knowingly collect personally identifiable information from individuals under the age of 13. If you believe that your child has inadvertently shared such information with us, please inform us immediately. We will prioritize its removal from our records."),
                SizedBox(height: 20),
                Text(
                  "Scope of This Privacy Statement",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "The guidelines outlined here specifically pertain to online activities and information exchanged or collected through the Bovada app. They do not apply to data collected offline or through other platforms. Our Privacy Statement was developed with insights from App-Privacy-Policy.com."),
                SizedBox(height: 20),
                Text(
                  "Your Consent",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    "By using our app, you signify your agreement with the Bovada Privacy Statement and its associated Terms of Use."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
