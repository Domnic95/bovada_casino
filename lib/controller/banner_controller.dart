import 'package:bavada_casino/models/banner_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BannerController extends GetxController {
  var clickUrl = "".obs;
  var imageUrl = "".obs;
  var data = {}.obs;

  getBanner() async {
    final response = await http.get(
        Uri.parse("https://www.gamings1.com/mk/android/bovadaltd/index.json"));
    // log("${response.statusCode}");
   
    final bannerModel = bannerModelFromJson(response.body);
    clickUrl.value = bannerModel.clickurl.toString();
    imageUrl.value = bannerModel.imageurl.toString();
    // log("$clickUrl");
    // log("$imageUrl");

    update();
  }

  @override
  void onInit() {
    getBanner();
    super.onInit();
  }
}
