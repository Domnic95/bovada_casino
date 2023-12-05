import 'dart:async';
import 'package:bavada_casino/controller/location_controller.dart';
import 'package:bavada_casino/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  MarkerId homeMarkerId = const MarkerId("homeMarkerId");
  ScrollController scrollController = ScrollController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> moveCamera(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 9,
    )));
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // @override
  // void initState() {
  //   final cont = Get.put(LocationController());
  //   cont.getLocations();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      child: GetBuilder<LocationController>(
          init: LocationController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 300,
                  child: controller.lat.toDouble() == 0.0
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GoogleMap(
                          gestureRecognizers: {
                            Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer()),
                          },
                          markers: {
                            Marker(
                              markerId: const MarkerId("homeMarkerId"),
                              position: LatLng(
                                controller.lat.toDouble(),
                                controller.lng.toDouble(),
                              ),
                              infoWindow:
                                  InfoWindow(title: "${controller.title}"),
                            )
                          },
                          mapType: MapType.normal,
                          onMapCreated: onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              controller.lat.toDouble(),
                              controller.lng.toDouble(),
                            ),
                            zoom: 7,
                          ),
                        ),
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.location.length,
                  separatorBuilder: (context, ind) {
                    return const Divider(
                      color: Colors.black,
                      thickness: 0.5,
                      indent: 10,
                      endIndent: 10,
                      height: 0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return controller.location.isNotEmpty
                        ? GestureDetector(
                            onTap: () async {
                              await controller.addMarker(
                                name:
                                    controller.location[index].name.toString(),
                                lati:
                                    controller.location[index].coordinates![0],
                                long:
                                    controller.location[index].coordinates![1],
                              );
                              moveCamera(
                                controller.location[index].coordinates![0],
                                controller.location[index].coordinates![1],
                              );
                              scrollController.jumpTo(
                                  scrollController.position.minScrollExtent);
                              controller.getValues(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.55,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.location[index].name}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.location[index].fiveStarRatingPublished}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            RatingStars(
                                              editable: false,
                                              rating: controller.location[index]
                                                  .fiveStarRatingPublished!
                                                  .toDouble(),
                                              color: Colors.amber,
                                              iconSize: 18,
                                            ),
                                          ],
                                        ),
                                        // const Text(
                                        //   "Casino",
                                        //   style: TextStyle(
                                        //       fontSize: 13,
                                        //       fontWeight: FontWeight.bold),
                                        // ),
                                        Text(
                                          "${controller.location[index].address}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${controller.location[index].status}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${controller.location[index].imageUrl}",
                                      fit: BoxFit.cover,
                                      width: size.width * .25,
                                      height: size.width * .25,
                                      placeholder: (context, string) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, string, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ],
            );
          }),
    );
  }
}
