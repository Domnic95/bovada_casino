import 'dart:convert';
import 'dart:developer';
import 'package:bavada_casino/models/location_model.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxList<Data> location = <Data>[].obs;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxString title = "".obs;
  // RxString name = "".obs;
  RxString address = "".obs;
  RxString image = "".obs;
  RxString status = "".obs;
  RxDouble rating = 0.0.obs;
  RxString destination = "".obs;
  var isLoading = true.obs;

  getLocations() async {
    isLoading.value = true;
    final String response =
        await rootBundle.loadString("assets/json/location.json");
    final result = await json.decode(response);
    LocationModel locationModel = LocationModel.fromJson(result);
    location.value = locationModel.data!.toList();
    lat.value = lat.toDouble() == 0.0 ? location[0].coordinates![0] : lat.value;
    lng.value = lng.toDouble() == 0.0 ? location[0].coordinates![1] : lng.value;
    title.value = location[0].name.toString();
    address.value = location[0].address.toString();
    image.value = location[0].imageUrl.toString();
    status.value = location[0].status.toString();
    rating.value = location[0].fiveStarRatingPublished!.toDouble();

    isLoading.value = false;

    // log("==================${location[0].address}");
    update();
  }

  getValues(int index) {
    address.value = location[index].address.toString();
    image.value = location[index].imageUrl.toString();
    status.value = location[index].status.toString();
    rating.value = location[index].fiveStarRatingPublished!.toDouble();

    update();
  }

  addMarker(
      {required String name, required double lati, required double long}) {
    title.value = name;
    lat.value = lati;
    lng.value = long;
    update();
  }

  getDestination(double lati, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lati,
        long,
      );
      Placemark place = placemarks[0];

      destination.value =
          "${place.locality} ${place.administrativeArea} ${place.isoCountryCode}";

      update();

      log(destination.toString());
    } catch (e) {
      throw Exception(e);
    }
    update();
  }
}
