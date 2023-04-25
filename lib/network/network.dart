import 'dart:convert';

import 'package:appnews/constantfile/constantfile.dart';
import 'package:appnews/login.dart';
import 'package:appnews/model/modelnews.dart';
import 'package:appnews/model/modeluser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkProvider{

  Future<ModelUser?> loginDataUser(String email, String password) async {
    final response = await http.post(Uri.parse(ConstantFile.url + "login.php"), body: {
      'email': email,
      'password': password,
    },
        headers: {
          'Accept': 'application/json',
        }
    );

    try{
      ModelUser dataUser = modelUserFromJson(response.body);
      if(dataUser.status == 200){
        return dataUser;
      }else{
        print("Data Error");
        return null;
      }
    }catch(exp){}

  }

  Future<void> logoutUser(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("dataUser");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }

  Future<ModelUser> registrasiUser(
      String username,
      String email,
      String password
      ) async{
    final response = await http.post(Uri.parse(ConstantFile.url + "registrasi.php"),
      body: {
        'username': username,
        'email': email,
        'password': password
      }
    );

    ModelUser addUser = await modelUserFromJson(response.body);
    return addUser;

  }

  Future<List<ModelNews>> getDataNews() async{
    final response = await http.get(Uri.parse(ConstantFile.url + "selectnews.php"));

    List<ModelNews> getNews = modelNewsFromJson(response.body);
    return getNews;
  }




}