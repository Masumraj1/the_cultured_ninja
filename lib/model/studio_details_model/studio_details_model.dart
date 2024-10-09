import 'dart:convert';

class StudioDetailsResponse {
  bool? success;
  StudioDetails? data;

  StudioDetailsResponse({this.success, this.data});

  factory StudioDetailsResponse.fromRawJson(String str) =>
      StudioDetailsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudioDetailsResponse.fromJson(Map<String, dynamic> json) =>
      StudioDetailsResponse(
        success: json["success"],
        data: json["data"] == null ? null : StudioDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class StudioDetails {
  Details? details;
  List<RelatedStudio>? relatedStudios;

  StudioDetails({this.details, this.relatedStudios});

  factory StudioDetails.fromRawJson(String str) =>
      StudioDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudioDetails.fromJson(Map<String, dynamic> json) => StudioDetails(
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
    relatedStudios: json["relatedStudios"] == null
        ? []
        : List<RelatedStudio>.from(json["relatedStudios"]
        .map((x) => RelatedStudio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "details": details?.toJson(),
    "relatedStudios": relatedStudios == null
        ? []
        : List<dynamic>.from(relatedStudios!.map((x) => x.toJson())),
  };
}

class Details {
  String? id;
  String? name;
  String? logo;
  int? totalMovies;
  String? createdAt;
  String? updatedAt;
  bool? isFollowed;

  Details({
    this.id,
    this.name,
    this.logo,
    this.totalMovies,
    this.createdAt,
    this.updatedAt,
    this.isFollowed,
  });

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    totalMovies: json["total_movies"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    isFollowed: json["isFollowed"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "logo": logo,
    "total_movies": totalMovies,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isFollowed": isFollowed,
  };
}

class RelatedStudio {
  String? id;
  String? name;
  String? logo;
  int? totalMovies;
  String? description;
  String? createdAt;
  String? updatedAt;

  RelatedStudio({
    this.id,
    this.name,
    this.logo,
    this.totalMovies,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory RelatedStudio.fromRawJson(String str) =>
      RelatedStudio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RelatedStudio.fromJson(Map<String, dynamic> json) => RelatedStudio(
    id: json["_id"],
    name: json["name"],
    logo: json["logo"],
    totalMovies: json["total_movies"],
    description: json["description"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "logo": logo,
    "total_movies": totalMovies,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
