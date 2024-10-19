import 'dart:convert';

class NotificationModel {
  bool? success;
  List<NotificationData>? data;
  Pagination? pagination;

  NotificationModel({
    this.success,
    this.data,
    this.pagination,
  });

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class NotificationData {
  String? id;
  List<dynamic>? seenBy;
  String? title;
  String? message;
  Movie? movie;
  String? type;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NotificationData({
    this.id,
    this.seenBy,
    this.title,
    this.message,
    this.movie,
    this.type,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationData.fromRawJson(String str) => NotificationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["_id"],
    seenBy: json["seenBy"] == null ? [] : List<dynamic>.from(json["seenBy"]!.map((x) => x)),
    title: json["title"],
    message: json["message"],
    movie: json["movie"] == null ? null : Movie.fromJson(json["movie"]),
    type: json["type"],
    user: json["user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "seenBy": seenBy == null ? [] : List<dynamic>.from(seenBy!.map((x) => x)),
    "title": title,
    "message": message,
    "movie": movie?.toJson(),
    "type": type,
    "user": user,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Movie {
  bool? adult;
  int? movieId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? poster;
  DateTime? releaseDate;
  String? title;

  Movie({
    this.adult,
    this.movieId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.poster,
    this.releaseDate,
    this.title,
  });

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    movieId: json["movie_id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    poster: json["poster"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "movie_id": movieId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster": poster,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "title": title,
  };
}

class Pagination {
  int? currentPage;
  int? itemsPerPage;
  int? totalItems;
  int? totalPages;

  Pagination({
    this.currentPage,
    this.itemsPerPage,
    this.totalItems,
    this.totalPages,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["currentPage"],
    itemsPerPage: json["itemsPerPage"],
    totalItems: json["totalItems"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "currentPage": currentPage,
    "itemsPerPage": itemsPerPage,
    "totalItems": totalItems,
    "totalPages": totalPages,
  };
}
