import 'package:flutter/material.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff2E0327),
          title: const Text(
            "Terms of Use",
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
                  "User Agreement for Bovada",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Introduction",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text("Welcome to Bovada!"),
                const Text(
                    "By accessing Bovada, you affirm your comprehension and acceptance of the terms outlined in this document. If you disagree with any aspect of these terms, we kindly request that you refrain from utilizing our platform."),
                const Text("For the purposes of this document:"),
                const SizedBox(
                  height: 5,
                ),
                dotRowTextConst(
                    """"User," "You," or "Your" pertains to you, the individual engaging with Bovada."""),
                dotRowTextConst(
                    """"Bovada," "We," "Our," or "Us" represents the Bovada platform and its entity."""),
                dotRowTextConst(
                    """"Party" or "Parties" encompasses both the User and Bovada."""),
                const Text(
                    "The terms outlined herein elucidate the understanding, acceptance, and any payment considerations essential for using our services, ensuring that the needs of both parties are met within the legal framework of the Netherlands. References in this document, whether singular or plural, carry the same significance.Intellectual Property"),
                const Text(
                    "All materials on Bovada, unless expressly stated otherwise, are the exclusive property of Bovada or its licensors and are rigorously protected. Users may access platform materials for personal use. However, it is strictly prohibited to:"),
                const SizedBox(
                  height: 5,
                ),
                dotRowTextConst(
                    "Redistribute, republish, or utilize Bovada content without prior authorization."),
                dotRowTextConst(
                    "Monetize, lease, or sublicense any of Bovada's materials."),
                dotRowTextConst(
                    "Duplicate or reproduce any content from Bovada."),
                const Text(
                    "Your engagement with this platform signifies the commencement of this agreement. Bovada provides sections for users to express their opinions. Please be aware that these viewpoints solely represent their respective authors and not necessarily those of Bovada. We are not liable for any consequences arising from these comments, but we retain the right to monitor and remove content if deemed necessary. When posting comments on Bovada:"),
                const SizedBox(
                  height: 5,
                ),
                dotRowTextConst(
                    "You confirm that you possess all requisite permissions and rights."),
                dotRowTextConst(
                    "Ensure that no infringement of third-party intellectual property rights occurs."),
                dotRowTextConst(
                    "Ensure that comments are free of defamatory, harmful, or illicit content."),
                dotRowTextConst(
                    "Confirm that they will not be employed for unauthorized or commercial purposes."),
                const Text(
                    "By posting comments, you also grant Bovada a non-exclusive right to use, adapt, and authorize others to use and modify your comments in various forms.Links and Bovada Entities"),
                const Text(
                    "Government agencies, search engines, news outlets, and other Bovada entities may link to our platform without prior consent. Directories may hyperlink to Bovada, similar to other listed businesses. Recognized businesses, excluding non-profits with solicitation objectives, may also link to our platform."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dotRowTextConst(text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•	",
            style: TextStyle(
                // color: Appcolor.secondarycolor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  // color: Appcolor.betDarkGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
