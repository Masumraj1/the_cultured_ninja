import 'dart:convert';

class SelectStreamingModel {
  bool? success;
  List<StreamingDataSelect>? data;

  SelectStreamingModel({
    this.success,
    this.data,
  });

  factory SelectStreamingModel.fromRawJson(String str) => SelectStreamingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectStreamingModel.fromJson(Map<String, dynamic> json) => SelectStreamingModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<StreamingDataSelect>.from(json["data"]!.map((x) => StreamingDataSelect.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StreamingDataSelect {
  String? name;
  String? logo;
  int? providerId;

  StreamingDataSelect({
    this.name,
    this.logo,
    this.providerId,
  });

  factory StreamingDataSelect.fromRawJson(String str) => StreamingDataSelect.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamingDataSelect.fromJson(Map<String, dynamic> json) => StreamingDataSelect(
    name: json["name"],
    logo: json["logo"],
    providerId: json["providerId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logo": logo,
    "providerId": providerId,
  };
}
