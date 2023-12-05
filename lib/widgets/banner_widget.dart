import 'package:bavada_casino/const/color_const.dart';
import 'package:bavada_casino/controller/banner_controller.dart';
import 'package:bavada_casino/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      init: BannerController(),
      builder: (bannerController) {
        return GestureDetector(
          onTap: () {
            if (bannerController.clickUrl.toString() != "#") {
              launchUrl(Uri.parse(bannerController.clickUrl.toString()),
                  mode: LaunchMode.externalApplication);
            }
          },
          child: Container(
            width: size.width,
            height: 60,
            color: AppColor.primaryColor,
            child: bannerController.clickUrl.toString() == ""
                ? const SizedBox()
                : CachedNetworkImage(
                    imageUrl: "${bannerController.imageUrl}",
                    fit: BoxFit.cover,
                    placeholder: (context, string) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, string, error) =>
                        const Icon(Icons.error),
                  ),
          ),
        );
      },
    );
  }
}
