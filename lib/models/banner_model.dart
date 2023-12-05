// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
    String? clickurl;
    String? imageurl;

    BannerModel({
        this.clickurl,
        this.imageurl,
    });

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        clickurl: json["clickurl"],
        imageurl: json["imageurl"],
    );

    Map<String, dynamic> toJson() => {
        "clickurl": clickurl,
        "imageurl": imageurl,
    };
}
