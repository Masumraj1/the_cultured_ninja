import 'dart:convert';

class StrreamingActorModel {
  bool? success;
  List<StreamingActorSelectList>? data;

  StrreamingActorModel({
    this.success,
    this.data,
  });

  factory StrreamingActorModel.fromRawJson(String str) => StrreamingActorModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StrreamingActorModel.fromJson(Map<String, dynamic> json) => StrreamingActorModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<StreamingActorSelectList>.from(json["data"]!.map((x) => StreamingActorSelectList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StreamingActorSelectList {
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

  StreamingActorSelectList({
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
  });

  factory StreamingActorSelectList.fromRawJson(String str) => StreamingActorSelectList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamingActorSelectList.fromJson(Map<String, dynamic> json) => StreamingActorSelectList(
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
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "background_color": backgroundColor,
    "movie_types": movieTypes == null ? [] : List<dynamic>.from(movieTypes!.map((x) => x)),
    "movie_id": movieId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster": poster,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "title": title,
    "video": video,
    "rating": rating,
    "vote": vote,
  };
}
