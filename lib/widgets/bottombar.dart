import 'package:bavada_casino/routs/routs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  final String? location;
  final Position? position;
  const BottomBar({super.key, this.location, this.position});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: const Column(
                children: [
                  Icon(
                    Icons.my_location,
                    size: 16,
                  ),
                  Text("Location"),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.offNamed(
                Routs.navigationScreen,
                arguments: {
                  "location": location,
                  "position": position,
                },
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.move_down,
                    size: 16,
                  ),
                  Text("Move"),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Column(
                children: [
                  Icon(
                    Icons.settings,
                    size: 16,
                  ),
                  Text("setting"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
