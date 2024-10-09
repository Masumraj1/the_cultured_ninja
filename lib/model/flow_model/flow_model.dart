import 'dart:convert';

class FlowModel {
  bool? success;
  FlowData? data;

  FlowModel({
    this.success,
    this.data,
  });

  factory FlowModel.fromRawJson(String str) => FlowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlowModel.fromJson(Map<String, dynamic> json) => FlowModel(
    success: json["success"],
    data: json["data"] == null ? null : FlowData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class FlowData {
  List<Studio>? studios;
  List<Actor>? actors;

  FlowData({
    this.studios,
    this.actors,
  });

  factory FlowData.fromRawJson(String str) => FlowData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FlowData.fromJson(Map<String, dynamic> json) => FlowData(
    studios: json["studios"] == null ? [] : List<Studio>.from(json["studios"]!.map((x) => Studio.fromJson(x))),
    actors: json["actors"] == null ? [] : List<Actor>.from(json["actors"]!.map((x) => Actor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "studios": studios == null ? [] : List<dynamic>.from(studios!.map((x) => x.toJson())),
    "actors": actors == null ? [] : List<dynamic>.from(actors!.map((x) => x.toJson())),
  };
}

class Actor {
  String? id;
  String? name;
  String? image;

  Actor({
    this.id,
    this.name,
    this.image,
  });

  factory Actor.fromRawJson(String str) => Actor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class Studio {
  String? id;
  String? name;
  String? logo;

  Studio({
    this.id,
    this.name,
    this.logo,
  });

  factory Studio.fromRawJson(String str) => Studio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Studio.fromJson(Map<String, dynamic> json) => Studio(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
  };
}
