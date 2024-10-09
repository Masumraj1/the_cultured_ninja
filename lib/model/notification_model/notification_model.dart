import 'dart:convert';

class NotificationModel {
  bool? success;
  List<NotificationData>? data;

  NotificationModel({
    this.success,
    this.data,
  });

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationData {
  String? id;
  List<dynamic>? seenBy;
  String? title;
  Message? message;
  Movie? movie;
  DatumType? type;
  dynamic user;
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
    message: messageValues.map[json["message"]]!,
    movie: json["movie"] == null ? null : Movie.fromJson(json["movie"]),
    type: datumTypeValues.map[json["type"]]!,
    user: json["user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "seenBy": seenBy == null ? [] : List<dynamic>.from(seenBy!.map((x) => x)),
    "title": title,
    "message": messageValues.reverse[message],
    "movie": movie?.toJson(),
    "type": datumTypeValues.reverse[type],
    "user": user,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Message {
  MOVIE_ID_66_FA8_FF9_B434_C3_A2_BE5300_B7_IS_NOW_AVAILABLE
}

final messageValues = EnumValues({
  "Movie ID 66fa8ff9b434c3a2be5300b7 is now available!": Message.MOVIE_ID_66_FA8_FF9_B434_C3_A2_BE5300_B7_IS_NOW_AVAILABLE
});

class Movie {
  Id? id;
  bool? adult;
  String? backgroundColor;
  List<int>? movieTypes;
  int? movieId;
  OriginalLanguage? originalLanguage;
  OriginalTitleEnum? originalTitle;
  String? overview;
  double? popularity;
  String? poster;
  DateTime? releaseDate;
  String? title;
  bool? video;
  int? rating;
  int? vote;
  StudioId? studioId;
  MovieType? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Movie({
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

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: idValues.map[json["_id"]]!,
    adult: json["adult"],
    backgroundColor: json["background_color"],
    movieTypes: json["movie_types"] == null ? [] : List<int>.from(json["movie_types"]!.map((x) => x)),
    movieId: json["movie_id"],
    originalLanguage: originalLanguageValues.map[json["original_language"]]!,
    originalTitle: originalTitleEnumValues.map[json["original_title"]]!,
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    poster: json["poster"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    title: json["title"],
    video: json["video"],
    rating: json["rating"],
    vote: json["vote"],
    studioId: studioIdValues.map[json["studio_id"]]!,
    type: movieTypeValues.map[json["type"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "adult": adult,
    "background_color": backgroundColor,
    "movie_types": movieTypes == null ? [] : List<dynamic>.from(movieTypes!.map((x) => x)),
    "movie_id": movieId,
    "original_language": originalLanguageValues.reverse[originalLanguage],
    "original_title": originalTitleEnumValues.reverse[originalTitle],
    "overview": overview,
    "popularity": popularity,
    "poster": poster,
    "release_date": releaseDate?.toIso8601String(),
    "title": title,
    "video": video,
    "rating": rating,
    "vote": vote,
    "studio_id": studioIdValues.reverse[studioId],
    "type": movieTypeValues.reverse[type],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Id {
  THE_66_FA8_FF9_B434_C3_A2_BE5300_B7
}

final idValues = EnumValues({
  "66fa8ff9b434c3a2be5300b7": Id.THE_66_FA8_FF9_B434_C3_A2_BE5300_B7
});

enum OriginalLanguage {
  EN
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN
});

enum OriginalTitleEnum {
  SAVING_BIKINI_BOTTOM_THE_SANDY_CHEEKS_MOVIE
}

final originalTitleEnumValues = EnumValues({
  "Saving Bikini Bottom: The Sandy Cheeks Movie": OriginalTitleEnum.SAVING_BIKINI_BOTTOM_THE_SANDY_CHEEKS_MOVIE
});

enum StudioId {
  THE_66_D815_CB9_AAB845_AE6_A03913
}

final studioIdValues = EnumValues({
  "66d815cb9aab845ae6a03913": StudioId.THE_66_D815_CB9_AAB845_AE6_A03913
});

enum MovieType {
  MOVIE
}

final movieTypeValues = EnumValues({
  "movie": MovieType.MOVIE
});

enum DatumTitle {
  NEW_MOVIE_RELEASE
}

final datumTitleValues = EnumValues({
  "New Movie Release": DatumTitle.NEW_MOVIE_RELEASE
});

enum DatumType {
  RELIES
}

final datumTypeValues = EnumValues({
  "relies": DatumType.RELIES
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
