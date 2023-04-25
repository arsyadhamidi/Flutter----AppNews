// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    this.status,
    this.error,
    this.message,
    this.data,
  });

  int? status;
  bool? error;
  String? message;
  Data? data;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    status: json["status"],
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.idUsers,
    this.username,
    this.email,
    this.password,
    this.level,
    this.registrasiDate,
  });

  String? the0;
  String? the1;
  String? the2;
  String? the3;
  String? the4;
  DateTime? the5;
  String? idUsers;
  String? username;
  String? email;
  String? password;
  String? level;
  DateTime? registrasiDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"] == null ? null : DateTime.parse(json["5"]),
    idUsers: json["id_users"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    level: json["level"],
    registrasiDate: json["registrasi_date"] == null ? null : DateTime.parse(json["registrasi_date"]),
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "1": the1,
    "2": the2,
    "3": the3,
    "4": the4,
    "5": the5?.toIso8601String(),
    "id_users": idUsers,
    "username": username,
    "email": email,
    "password": password,
    "level": level,
    "registrasi_date": registrasiDate?.toIso8601String(),
  };
}
