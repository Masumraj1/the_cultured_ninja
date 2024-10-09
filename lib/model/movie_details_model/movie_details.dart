import 'dart:convert';

class MovieDetails {
  bool? success;
  DetailsData? data;

  MovieDetails({
    this.success,
    this.data,
  });

  factory MovieDetails.fromRawJson(String str) =>
      MovieDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      MovieDetails(
        success: json["success"],
        data: json["data"] == null ? null : DetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "success": success,
        "data": data?.toJson(),
      };
}

class DetailsData {
  Details? details;
  List<Trailer>? trailer;
  List<Platform>? platform;
  List<Actor>? actors;
  List<SimilarMovies>? similarMovies;
  bool? favorite;
  bool? watched;

  DetailsData({
    this.details,
    this.trailer,
    this.platform,
    this.actors,
    this.similarMovies,
    this.favorite,
    this.watched
  });

  factory DetailsData.fromRawJson(String str) =>
      DetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailsData.fromJson(Map<String, dynamic> json) =>
      DetailsData(
        details: json["details"] == null ? null : Details.fromJson(
            json["details"]),
        trailer: json["trailer"] == null ? [] : List<Trailer>.from(
            json["trailer"]!.map((x) => Trailer.fromJson(x))),
        platform: json["platform"] == null ? [] : List<Platform>.from(
            json["platform"]!.map((x) => Platform.fromJson(x))),

        actors: json["actors"] == null ? <Actor>[] : List<Actor>.from(
            json["actors"].map((x) => Actor.fromJson(x))),

        similarMovies: json["similarMovies"] == null ? <SimilarMovies>[] : List<SimilarMovies>.from(
            json["similarMovies"].map((x) => SimilarMovies.fromJson(x))),

        favorite: json["favorite"],
        watched: json["watched"],
      );

  Map<String, dynamic> toJson() =>
      {
        "details": details?.toJson(),
        "trailer": trailer == null ? [] : List<dynamic>.from(
            trailer!.map((x) => x.toJson())),
        "platform": platform == null ? [] : List<dynamic>.from(
            platform!.map((x) => x.toJson())),
        "actors": actors == null ? [] : List<dynamic>.from(
            actors!.map((x) => x.toJson())),
        "similarMovies": similarMovies == null ? [] : List<dynamic>.from(
            similarMovies!.map((x) => x.toJson())),

        "favorite": favorite,
        "watched": watched,
      };
}


enum KnownForDepartment {
  ACTING,
  CREW
}

final knownForDepartmentValues = EnumValues({
  "Acting": KnownForDepartment.ACTING,
  "Crew": KnownForDepartment.CREW
});


class Details {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  DateTime? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Details({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Details.fromRawJson(String str) => Details.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Details.fromJson(Map<String, dynamic> json) =>
      Details(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"] == null
            ? null
            : BelongsToCollection.fromJson(json["belongs_to_collection"]),
        budget: json["budget"],
        genres: json["genres"] == null ? [] : List<Genre>.from(
            json["genres"]!.map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originCountry: json["origin_country"] == null ? [] : List<String>.from(
            json["origin_country"]!.map((x) => x)),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null ? [] : List<
            ProductionCompany>.from(json["production_companies"]!.map((x) =>
            ProductionCompany.fromJson(x))),
        productionCountries: json["production_countries"] == null ? [] : List<
            ProductionCountry>.from(json["production_countries"]!.map((x) =>
            ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] == null ? null : DateTime.parse(
            json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: json["spoken_languages"] == null ? [] : List<
            SpokenLanguage>.from(
            json["spoken_languages"]!.map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() =>
      {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection?.toJson(),
        "budget": budget,
        "genres": genres == null ? [] : List<dynamic>.from(
            genres!.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "origin_country": originCountry == null ? [] : List<dynamic>.from(
            originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null ? [] : List<
            dynamic>.from(productionCompanies!.map((x) => x.toJson())),
        "production_countries": productionCountries == null ? [] : List<
            dynamic>.from(productionCountries!.map((x) => x.toJson())),
        "release_date": "${releaseDate!.year.toString().padLeft(
            4, '0')}-${releaseDate!.month.toString().padLeft(
            2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages": spokenLanguages == null ? [] : List<dynamic>.from(
            spokenLanguages!.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory BelongsToCollection.fromRawJson(String str) =>
      BelongsToCollection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      BelongsToCollection(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"],
        backdropPath: json["backdrop_path"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "poster_path": posterPath,
        "backdrop_path": backdropPath,
      };
}

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromRawJson(String str) =>
      ProductionCompany.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({
    this.iso31661,
    this.name,
  });

  factory ProductionCountry.fromRawJson(String str) =>
      ProductionCountry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromRawJson(String str) =>
      SpokenLanguage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}

class Platform {
  String? logoPath;
  int? providerId;
  String? providerName;
  int? displayPriority;

  Platform({
    this.logoPath,
    this.providerId,
    this.providerName,
    this.displayPriority,
  });

  factory Platform.fromRawJson(String str) =>
      Platform.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Platform.fromJson(Map<String, dynamic> json) =>
      Platform(
        logoPath: json["logo_path"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
        displayPriority: json["display_priority"],
      );

  Map<String, dynamic> toJson() =>
      {
        "logo_path": logoPath,
        "provider_id": providerId,
        "provider_name": providerName,
        "display_priority": displayPriority,
      };
}

class Actor {
  bool? adult;
  int? gender;
  int? id;
  KnownForDepartment? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  factory Actor.fromRawJson(String str) => Actor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Actor.fromJson(Map<String, dynamic> json) =>
      Actor(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() =>
      {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartmentValues
            .reverse[knownForDepartment],
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
      };
}


class SimilarMovies {
  String? title;
  String? posterPath;

  SimilarMovies({this.title,this.posterPath});

  // Factory constructor to create an instance from raw JSON string
  factory SimilarMovies.fromRawJson(String str) => SimilarMovies.fromJson(json.decode(str));

  // Method to convert the object to a raw JSON string
  String toRawJson() => json.encode(toJson());

  // Factory constructor to create an instance from JSON map
  factory SimilarMovies.fromJson(Map<String, dynamic> json) => SimilarMovies(
    title: json["title"],  posterPath: json["poster_path"],  // Assuming the key in the JSON is "name" for movie title
  );

  // Method to convert the object to JSON map
  Map<String, dynamic> toJson() => {
    "title": title, "poster_path": posterPath,  // Matching the key from JSON
  };
}

class Trailer {
  String? url;
  String? name;

  Trailer({
    this.url,
    this.name,
  });

  factory Trailer.fromRawJson(String str) => Trailer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Trailer.fromJson(Map<String, dynamic> json) =>
      Trailer(
        url: json["url"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() =>
      {
        "url": url,
        "name": name,
      };
}

enum Type {
  BEHIND_THE_SCENES,
  BLOOPERS,
  FEATURETTE,
  TEASER,
  TRAILER
}

final typeValues = EnumValues({
  "Behind the Scenes": Type.BEHIND_THE_SCENES,
  "Bloopers": Type.BLOOPERS,
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
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
