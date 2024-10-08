// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool? success;
  ProfileData? data;

  ProfileModel({
    this.success,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class ProfileData {
  String? id;
  String? img;
  String? name;
  String? email;
  String? password;
  String? provider;
  bool? block;
  String? role;
  int? access;
  bool? verified;
  String? address;
  int? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileData({
    this.id,
    this.img,
    this.name,
    this.email,
    this.password,
    this.provider,
    this.block,
    this.role,
    this.access,
    this.verified,
    this.address,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["_id"],
    img: json["img"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    provider: json["provider"],
    block: json["block"],
    role: json["role"],
    access: json["access"],
    verified: json["verified"],
    address: json["address"],
    phone: json["phone"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "img": img,
    "name": name,
    "email": email,
    "password": password,
    "provider": provider,
    "block": block,
    "role": role,
    "access": access,
    "verified": verified,
    "address": address,
    "phone": phone,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
