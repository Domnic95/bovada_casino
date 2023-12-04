import 'dart:async';
import 'package:bavada_casino/controller/location_controller.dart';
import 'package:bavada_casino/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Position? _position;
  String? _currentLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  MarkerId currentMarkerId = const MarkerId("currentMarkerId");
  MarkerId destinationMarkerId = const MarkerId("destinationMarkerId");

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      _position = position;
    });
    getAddress();
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are Denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are Permanent Denied");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> moveCamera(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 3,
    )));
  }

  getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _position!.latitude,
        _position!.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentLocation =
            "${place.locality} ${place.administrativeArea} ${place.isoCountryCode}";

        Marker currentMarker = Marker(
          markerId: MarkerId("$currentMarkerId"),
          position: LatLng(
            _position!.latitude,
            _position!.longitude,
          ),
          infoWindow: InfoWindow(title: "$_currentLocation"),
        );
        _markers[currentMarkerId] = currentMarker;
      });
      // log(_currentLocation.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    final cont = Get.find<LocationController>();
    cont.getDestination(cont.lat.toDouble(), cont.lng.toDouble());
    getCurrentLocation();

    Marker destinationMarker = Marker(
      markerId: MarkerId("$destinationMarkerId"),
      position: LatLng(cont.lat.toDouble(), cont.lng.toDouble()),
      infoWindow: InfoWindow(title: "${cont.destination}"),
    );
    setState(() {
      _markers[destinationMarkerId] = destinationMarker;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GetBuilder<LocationController>(
          init: LocationController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  height: 45,
                  width: size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Text(
                    _currentLocation == null ? "" : _currentLocation.toString(),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 45,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      itemHeight: 130,
                      onChanged: (value) {
                        controller.title.value = value!.name.toString();
                        controller.getValues(value.id! - 1);
                        controller.lat.value = value.coordinates![0];
                        controller.lng.value = value.coordinates![1];

                        Marker newMarker = Marker(
                          markerId: MarkerId("$destinationMarkerId"),
                          position: LatLng(
                            controller.lat.toDouble(),
                            controller.lng.toDouble(),
                          ),
                          infoWindow: InfoWindow(title: "${controller.title}"),
                        );

                        moveCamera(
                          controller.lat.toDouble(),
                          controller.lng.toDouble(),
                        );
                        setState(() {
                          _markers[destinationMarkerId] = newMarker;
                        });
                      },
                      hint: Text(
                        controller.title.toString(),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      items: controller.location.map((element) {
                        return DropdownMenuItem(
                          value: element,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${element.name}",
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
                                            "${element.fiveStarRatingPublished}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          RatingStars(
                                            editable: false,
                                            rating: element
                                                .fiveStarRatingPublished!
                                                .toDouble(),
                                            color: Colors.amber,
                                            iconSize: 18,
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Casino",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${element.address}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${element.status}",
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
                                    imageUrl: "${element.imageUrl}",
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

                          // child: Text("${element.name}"),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  // width: size.width,
                  // height: size.height * 0.49,
                  child: _position == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GoogleMap(
                          mapType: MapType.normal,
                          onMapCreated: onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              controller.lat.toDouble(),
                              controller.lng.toDouble(),
                            ),
                            zoom: 3,
                          ),
                          markers: Set<Marker>.of(_markers.values),
                          // markers: {
                          //   Marker(
                          //     markerId:
                          //
                          //
                          // ("${controller.lat}"),
                          //     position: LatLng(
                          //       controller.lat.toDouble(),
                          //       controller.lng.toDouble(),
                          //     ),
                          //     infoWindow:
                          //         InfoWindow(title: "${controller.title}"),
                          //   ),
                          //   Marker(
                          //     markerId: MarkerId("${_position!.latitude}"),
                          //     position: LatLng(
                          //       _position!.latitude,
                          //       _position!.longitude,
                          //     ),
                          //     infoWindow:
                          //         InfoWindow(title: "$_currentLocation"),
                          //   ),
                          // },
                        ),
                ),
                // const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.55,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.title}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.rating}",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                RatingStars(
                                  editable: false,
                                  rating: controller.rating.toDouble(),
                                  color: Colors.amber,
                                  iconSize: 18,
                                ),
                              ],
                            ),
                            const Text(
                              "Casino",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${controller.address}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${controller.status}",
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
                          imageUrl: "${controller.image}",
                          fit: BoxFit.cover,
                          width: size.width * .25,
                          height: size.width * .25,
                          placeholder: (context, string) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, string, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
