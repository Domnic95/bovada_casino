import 'package:bavada_casino/const/color_const.dart';
import 'package:bavada_casino/controller/location_controller.dart';
import 'package:bavada_casino/main.dart';
import 'package:bavada_casino/widgets/banner_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          const BannerWidget(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<LocationController>(
                  init: LocationController(),
                  builder: (controller) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/banner1 (1).png",
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "300+ Locations",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        const Text(
                          "across the USA",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Welcome to the definitive guide to Bavada's 300+ Locations across the USA. Dive in to explore our extensive directory of gaming havens, complete with addresses and contact details. Whether you're a seasoned player or a first-timer, your ultimate casino experience is just a click away.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // GetBuilder<LocationController>(
                        //     init: LocationController(),
                        //     builder: (controller) {
                        controller.location.isEmpty
                        ? const Center(child: CircularProgressIndicator(),)
                        : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10,
                              color: Colors.transparent,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "${controller.location[index].imageUrl}",
                                        width: size.width,
                                        height: 280,
                                        fit: BoxFit.cover,
                                        placeholder: (context, string) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, string, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${controller.location[index].status}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${controller.location[index].fiveStarRatingPublished}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        RatingStars(
                                          editable: false,
                                          rating: controller.location[index]
                                              .fiveStarRatingPublished!
                                              .toDouble(),
                                          color: Colors.amber,
                                          iconSize: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${controller.location[index].name}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "${controller.location[index].address}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, ind) {
                            return const SizedBox(height: 10);
                          },
                        ),
                        // }),
                        const SizedBox(height: 50),
                        const Text(
                          "BovadaLtd",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
