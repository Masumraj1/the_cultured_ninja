// To parse this JSON data, do
//
//     final allStreamingModel = allStreamingModelFromJson(jsonString);

import 'dart:convert';

AllStreamingModel allStreamingModelFromJson(String str) => AllStreamingModel.fromJson(json.decode(str));

String allStreamingModelToJson(AllStreamingModel data) => json.encode(data.toJson());

class AllStreamingModel {
  bool? success;
  List<StreamingData>? data;

  AllStreamingModel({
    this.success,
    this.data,
  });

  factory AllStreamingModel.fromJson(Map<String, dynamic> json) => AllStreamingModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<StreamingData>.from(json["data"]!.map((x) => StreamingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StreamingData {
  String? id;
  String? name;
  String? logo;
  int? totalMovies;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  StreamingData({
    this.id,
    this.name,
    this.logo,
    this.totalMovies,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory StreamingData.fromJson(Map<String, dynamic> json) => StreamingData(
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
