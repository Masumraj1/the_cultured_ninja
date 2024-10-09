import 'dart:convert';

class ActorDetailsModel {
  bool? success;
  ActorDetailsData? data;

  ActorDetailsModel({
    this.success,
    this.data,
  });

  factory ActorDetailsModel.fromRawJson(String str) => ActorDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActorDetailsModel.fromJson(Map<String, dynamic> json) => ActorDetailsModel(
    success: json["success"],
    data: json["data"] == null ? null : ActorDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class ActorDetailsData {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  DateTime? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;

  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;
  bool? isFollowed;
  List<Movie>? upcomingMovies;
  List<Movie>? popularMovies;

  ActorDetailsData({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
    this.isFollowed,
    this.upcomingMovies,
    this.popularMovies,
  });

  factory ActorDetailsData.fromRawJson(String str) => ActorDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ActorDetailsData.fromJson(Map<String, dynamic> json) => ActorDetailsData(
    adult: json["adult"],
    alsoKnownAs: json["also_known_as"] == null ? [] : List<String>.from(json["also_known_as"]!.map((x) => x)),
    biography: json["biography"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    deathday: json["deathday"],
    gender: json["gender"],
    homepage: json["homepage"],
    id: json["id"],
    imdbId: json["imdb_id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    placeOfBirth: json["place_of_birth"],
    popularity: json["popularity"]?.toDouble(),
    profilePath: json["profile_path"],
    isFollowed: json["isFollowed"],
    upcomingMovies: json["upcoming_movies"] == null ? [] : List<Movie>.from(json["upcoming_movies"]!.map((x) => Movie.fromJson(x))),
    popularMovies: json["popular_movies"] == null ? [] : List<Movie>.from(json["popular_movies"]!.map((x) => Movie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "also_known_as": alsoKnownAs == null ? [] : List<dynamic>.from(alsoKnownAs!.map((x) => x)),
    "biography": biography,
    "birthday": "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
    "deathday": deathday,
    "gender": gender,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "known_for_department": knownForDepartment,
    "name": name,
    "place_of_birth": placeOfBirth,
    "popularity": popularity,
    "profile_path": profilePath,
    "isFollowed":isFollowed,
    "upcoming_movies": upcomingMovies == null ? [] : List<dynamic>.from(upcomingMovies!.map((x) => x.toJson())),
    "popular_movies": popularMovies == null ? [] : List<dynamic>.from(popularMovies!.map((x) => x.toJson())),
  };
}

class Movie {
  int? id;
  String? title;
  String? releaseDate;
  double? popularity;
  MediaType? mediaType;
  String? posterPath;

  Movie({
    this.id,
    this.title,
    this.releaseDate,
    this.popularity,
    this.mediaType,
    this.posterPath,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json["id"],
    title: json["title"],
    releaseDate: json["release_date"],
    popularity: json["popularity"]?.toDouble(),
    mediaType: mediaTypeValues.map[json["media_type"]]!,
    posterPath: json["poster_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "release_date": releaseDate,
    "popularity": popularity,
    "media_type": mediaTypeValues.reverse[mediaType],
    "poster_path": posterPath,
  };
}

enum MediaType {
  MOVIE,
  TV
}

final mediaTypeValues = EnumValues({
  "movie": MediaType.MOVIE,
  "tv": MediaType.TV
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
