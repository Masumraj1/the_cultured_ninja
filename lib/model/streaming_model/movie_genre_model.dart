// To parse this JSON data, do
//
//     final movieGenreModel = movieGenreModelFromJson(jsonString);

import 'dart:convert';

MovieGenreModel movieGenreModelFromJson(String str) => MovieGenreModel.fromJson(json.decode(str));

String movieGenreModelToJson(MovieGenreModel data) => json.encode(data.toJson());

class MovieGenreModel {
  bool? success;
  List<MovieGenreData>? data;

  MovieGenreModel({
    this.success,
    this.data,
  });

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) => MovieGenreModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<MovieGenreData>.from(json["data"]!.map((x) => MovieGenreData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MovieGenreData {
  int? id;
  String? name;

  MovieGenreData({
    this.id,
    this.name,
  });

  factory MovieGenreData.fromJson(Map<String, dynamic> json) => MovieGenreData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
