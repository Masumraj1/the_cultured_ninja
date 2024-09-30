// To parse this JSON data, do
//
//     final baneerModel = baneerModelFromJson(jsonString);

import 'dart:convert';

BaneerModel baneerModelFromJson(String str) => BaneerModel.fromJson(json.decode(str));

String baneerModelToJson(BaneerModel data) => json.encode(data.toJson());

class BaneerModel {
  bool? success;
  List<BannerData>? data;

  BaneerModel({
    this.success,
    this.data,
  });

  factory BaneerModel.fromJson(Map<String, dynamic> json) => BaneerModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<BannerData>.from(json["data"]!.map((x) => BannerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BannerData {
  String? id;
  bool? adult;
  String? backgroundColor;
  List<int>? movieTypes;
  int? movieId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? poster;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? rating;
  int? vote;
  String? studioId;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BannerData({
    this.id,
    this.adult,
    this.backgroundColor,
    this.movieTypes,
    this.movieId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.poster,
    this.releaseDate,
    this.title,
    this.video,
    this.rating,
    this.vote,
    this.studioId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["_id"],
    adult: json["adult"],
    backgroundColor: json["background_color"],
    movieTypes: json["movie_types"] == null ? [] : List<int>.from(json["movie_types"]!.map((x) => x)),
    movieId: json["movie_id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    poster: json["poster"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    rating: json["rating"]?.toDouble(),
    vote: json["vote"],
    studioId: json["studio_id"],
    type: json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "adult": adult,
    "background_color": backgroundColor,
    "movie_types": movieTypes == null ? [] : List<dynamic>.from(movieTypes!.map((x) => x)),
    "movie_id": movieId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster": poster,
    "release_date": releaseDate?.toIso8601String(),
    "title": title,
    "video": video,
    "rating": rating,
    "vote": vote,
    "studio_id": studioId,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
