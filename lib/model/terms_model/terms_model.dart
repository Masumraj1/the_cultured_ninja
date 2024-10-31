import 'dart:convert';

class TermsModel {
  bool? success;
  TermsData? data;

  TermsModel({
    this.success,
    this.data,
  });

  factory TermsModel.fromRawJson(String str) => TermsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsModel.fromJson(Map<String, dynamic> json) => TermsModel(
    success: json["success"],
    data: json["data"] == null ? null : TermsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class TermsData {
  String? id;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? v;

  TermsData({
    this.id,
    this.name,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory TermsData.fromRawJson(String str) => TermsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TermsData.fromJson(Map<String, dynamic> json) => TermsData(
    id: json["_id"],
    name: json["name"],
    value: json["value"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "value": value,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}
