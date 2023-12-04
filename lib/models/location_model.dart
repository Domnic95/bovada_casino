class LocationModel {
  List<Data>? data;

  LocationModel({this.data});

  LocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? address;
  double? fiveStarRatingPublished;
  List<double>? coordinates;
  String? imageUrl;
  String? status;

  Data(
      {this.id,
      this.name,
      this.address,
      this.fiveStarRatingPublished,
      this.coordinates,
      this.imageUrl,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    fiveStarRatingPublished = json['five_star_rating_published'].toDouble();
    coordinates = json['coordinates'].cast<double>();
    imageUrl = json['imageUrl'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['five_star_rating_published'] = fiveStarRatingPublished;
    data['coordinates'] = coordinates;
    data['imageUrl'] = imageUrl;
    data['status'] = status;
    return data;
  }
}
