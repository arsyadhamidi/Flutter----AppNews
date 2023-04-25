// To parse this JSON data, do
//
//     final modelNews = modelNewsFromJson(jsonString);

import 'dart:convert';

List<ModelNews> modelNewsFromJson(String str) => List<ModelNews>.from(json.decode(str).map((x) => ModelNews.fromJson(x)));

String modelNewsToJson(List<ModelNews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelNews {
  ModelNews({
    this.the0,
    this.the1,
    this.the2,
    this.the3,
    this.the4,
    this.the5,
    this.the6,
    this.the7,
    this.the8,
    this.the9,
    this.the10,
    this.the11,
    this.the12,
    this.idNews,
    this.image,
    this.title,
    this.content,
    this.description,
    this.dateNews,
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
  String? the6;
  String? the7;
  String? the8;
  String? the9;
  String? the10;
  String? the11;
  DateTime? the12;
  String? idNews;
  String? image;
  String? title;
  String? content;
  String? description;
  DateTime? dateNews;
  String? idUsers;
  String? username;
  String? email;
  String? password;
  String? level;
  DateTime? registrasiDate;

  factory ModelNews.fromJson(Map<String, dynamic> json) => ModelNews(
    the0: json["0"],
    the1: json["1"],
    the2: json["2"],
    the3: json["3"],
    the4: json["4"],
    the5: json["5"] == null ? null : DateTime.parse(json["5"]),
    the6: json["6"],
    the7: json["7"],
    the8: json["8"],
    the9: json["9"],
    the10: json["10"],
    the11: json["11"],
    the12: json["12"] == null ? null : DateTime.parse(json["12"]),
    idNews: json["id_news"],
    image: json["image"],
    title: json["title"],
    content: json["content"],
    description: json["description"],
    dateNews: json["date_news"] == null ? null : DateTime.parse(json["date_news"]),
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
    "6": the6,
    "7": the7,
    "8": the8,
    "9": the9,
    "10": the10,
    "11": the11,
    "12": the12?.toIso8601String(),
    "id_news": idNews,
    "image": image,
    "title": title,
    "content": content,
    "description": description,
    "date_news": dateNews?.toIso8601String(),
    "id_users": idUsers,
    "username": username,
    "email": email,
    "password": password,
    "level": level,
    "registrasi_date": registrasiDate?.toIso8601String(),
  };
}
