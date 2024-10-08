import 'dart:convert';

class CalenderModel {
  bool? success;
  CalenderData? data;

  CalenderModel({
    this.success,
    this.data,
  });

  factory CalenderModel.fromRawJson(String str) => CalenderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
    success: json["success"],
    data: json["data"] == null ? null : CalenderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class CalenderData {
  List<Movie>? movies;
  List<Date>? dates;

  CalenderData({
    this.movies,
    this.dates,
  });

  factory CalenderData.fromRawJson(String str) => CalenderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CalenderData.fromJson(Map<String, dynamic> json) => CalenderData(
    movies: json["movies"] == null ? [] : List<Movie>.from(json["movies"]!.map((x) => Movie.fromJson(x))),
    dates: json["dates"] == null ? [] : List<Date>.from(json["dates"]!.map((x) => Date.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "movies": movies == null ? [] : List<dynamic>.from(movies!.map((x) => x.toJson())),
    "dates": dates == null ? [] : List<dynamic>.from(dates!.map((x) => x.toJson())),
  };
}

class Date {
  Month? month;
  int? date;
  int? year;

  Date({
    this.month,
    this.date,
    this.year,
  });

  factory Date.fromRawJson(String str) => Date.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    month: monthValues.map[json["month"]]!,
    date: json["date"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "month": monthValues.reverse[month],
    "date": date,
    "year": year,
  };
}

enum Month {
  DECEMBER,
  MAY,
  NOVEMBER,
  OCTOBER
}

final monthValues = EnumValues({
  "December": Month.DECEMBER,
  "May": Month.MAY,
  "November": Month.NOVEMBER,
  "October": Month.OCTOBER
});

class Movie {
  bool? adult;
  String? backgroundColor;
  List<int>? movieTypes;
  int? movieId;
  OriginalLanguage? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? poster;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? rating;
  int? vote;

  Movie({
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

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backgroundColor: json["background_color"],
    movieTypes: json["movie_types"] == null ? [] : List<int>.from(json["movie_types"]!.map((x) => x)),
    movieId: json["movie_id"],
    originalLanguage: originalLanguageValues.map[json["original_language"]]!,
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
    "original_language": originalLanguageValues.reverse[originalLanguage],
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

enum OriginalLanguage {
  DE,
  EN
}

final originalLanguageValues = EnumValues({
  "de": OriginalLanguage.DE,
  "en": OriginalLanguage.EN
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
