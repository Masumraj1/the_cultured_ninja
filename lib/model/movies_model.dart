// To parse this JSON data, do
//
//     final moviesModel = moviesModelFromJson(jsonString);

import 'dart:convert';

MoviesModel moviesModelFromJson(String str) => MoviesModel.fromJson(json.decode(str));

String moviesModelToJson(MoviesModel data) => json.encode(data.toJson());

class MoviesModel {
  bool? success;
  List<MoviesData>? data;

  MoviesModel({
    this.success,
    this.data,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<MoviesData>.from(json["data"]!.map((x) => MoviesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MoviesData {
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

  MoviesData({
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

  factory MoviesData.fromJson(Map<String, dynamic> json) => MoviesData(
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
