// To parse this JSON data, do
//
//     final studioModel = studioModelFromJson(jsonString);

import 'dart:convert';

StudioModel studioModelFromJson(String str) => StudioModel.fromJson(json.decode(str));

String studioModelToJson(StudioModel data) => json.encode(data.toJson());

class StudioModel {
  bool? success;
  List<StudioData>? data;

  StudioModel({
    this.success,
    this.data,
  });

  factory StudioModel.fromJson(Map<String, dynamic> json) => StudioModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<StudioData>.from(json["data"]!.map((x) => StudioData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StudioData {
  String? id;
  String? name;
  String? logo;
  int? totalMovies;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  StudioData({
    this.id,
    this.name,
    this.logo,
    this.totalMovies,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory StudioData.fromJson(Map<String, dynamic> json) => StudioData(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    totalMovies: json["total_movies"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "logo": logo,
    "total_movies": totalMovies,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
