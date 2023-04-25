import 'dart:convert';

import 'package:appnews/home/home.dart';
import 'package:appnews/model/modeluser.dart';
import 'package:appnews/network/network.dart';
import 'package:appnews/registrasi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obsurce = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  void validasiLogin() async{
    if(_key.currentState!.validate()){
      if(_email.text.isEmpty || _password.text.isEmpty){
        print("Data Tidak Boleh Kosong");
      }else{
        ModelUser? lisData = await NetworkProvider().loginDataUser(
            _email.text,
            _password.text
        );
        if(lisData == null){
          print("Data Null");
        }else{
          ModelUser? dataUser = lisData;
          print(
              "Data : ${dataUser.data?.idUsers} ${dataUser.data?.username} ${dataUser.data?.email} ${dataUser.data?.registrasiDate}"
          );
          await savePreferences(dataUser);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => MenuHome()), (route) => false);
        }
      }
    }
  }

  Future<void> savePreferences(ModelUser dataUser) async{
    SharedPreferences prefsUser = await SharedPreferences.getInstance();
    prefsUser.setString('dataUser', jsonEncode(dataUser));
  }

  Future<void> cekSession() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var cekEmail = prefs.getString("dataUser");
    if(cekEmail != null){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => MenuHome()),
              (route) => false);
    }
  }

  void inHidePassword(){
    if(_obsurce == true){
      setState(() {
        _obsurce = false;
      });
    }else{
      setState(() {
        _obsurce = true;
      });
    }
  }



  @override
  void initState() {
    cekSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: ListView(
          children: [
            SizedBox(height: 100),
            Center(
              child: Text("FORM LOGIN!", style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.envelope),
                  hintText: "Enter Your Email...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                validator: (e){
                  if(e!.isEmpty){
                    return "Please enter your email!";
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: _password,
                obscureText: _obsurce,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: (){
                          inHidePassword();
                        },
                        icon: Icon(
                            _obsurce ? CupertinoIcons.eye_slash : CupertinoIcons.eye
                        )
                    ),
                    prefixIcon: Icon(CupertinoIcons.padlock),
                    hintText: "Enter your password...",
                    border: OutlineInputBorder(
                        borderSide: BorderSide()
                    )
                ),
                validator: (p){
                  if(p!.isEmpty){
                    return "Please enter your password!";
                  }
                },
              ),
            ),

            SizedBox(height: 30),

            Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      validasiLogin();
                    },
                    child: Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have your account ?",
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegistrasiPage()));
                    },
                    child: Text("Register !", style: TextStyle(fontSize: 17),),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
