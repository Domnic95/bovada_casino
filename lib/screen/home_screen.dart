import 'dart:async';
import 'dart:developer';
import 'package:bavada_casino/main.dart';
import 'package:bavada_casino/routs/routs.dart';
import 'package:bavada_casino/widgets/bottombar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _position;
  String? _currentLocation;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
      });
      log(_currentLocation.toString());
    } catch (e) {
      throw Exception(e);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        location: _currentLocation,
        position: _position,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 300,
                child: _position == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GoogleMap(
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer()),
                        },
                        mapType: MapType.normal,
                        onMapCreated: onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target:
                              LatLng(_position!.latitude, _position!.longitude),
                          zoom: 11,
                        ),
                      ),
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
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
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                      Routs.navigationScreen,
                      arguments: {
                        "location": _currentLocation,
                        "position": _position,
                      },
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 10),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.55,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bavada Casino Indiana",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "4.5 ****",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber,
                                  ),
                                ),
                                Text(
                                  "Casino",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Marion County, Indiana, USA",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "opens 24 hours",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * .25,
                            height: size.width * .25,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              "assets/images/img1.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
