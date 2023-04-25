import 'package:appnews/login.dart';
import 'package:appnews/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  
  GlobalKey<FormState> _key = GlobalKey();
  bool _obsurce = true;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  
  void validasiRegistrasi() async{
    if(_key.currentState!.validate()){
      if(_username.text.isEmpty || _email.text.isEmpty || _password.text.isEmpty){
        print("Data Cannot Be Empty");
      }else{
        NetworkProvider().registrasiUser(
            _username.text,
            _email.text,
            _password.text
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }

  void inHidePassword() async{
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(height: 100),
              Center(
                  child: Text("FORM REGISTRASI",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  hintText: "Enter your username...",
                  prefixIcon: Icon(CupertinoIcons.person),
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                validator: (u){
                  if(u!.isEmpty){
                    return "Please enter your username";
                  }
                  if(u.trim().length < 5){
                    return "Minimal 5 Character";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: "Enter your email...",
                  prefixIcon: Icon(CupertinoIcons.envelope),
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                validator: (e){
                  if(e!.isEmpty) {
                    return "Data is Cannot be Empty";
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: _obsurce,
                controller: _password,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  prefixIcon: Icon(CupertinoIcons.padlock),
                  suffixIcon: IconButton(
                      onPressed: (){
                        inHidePassword();
                      },
                      icon: Icon(_obsurce ? CupertinoIcons.eye_slash : CupertinoIcons.eye),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide()
                  )
                ),
                validator: (p){
                  if(p!.isEmpty){
                    return "Data is Cannot Be Empty";
                  }if(p.trim().length < 5){
                    return "Password minimal 5 Character";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    validasiRegistrasi();
                  },
                  child: Text("SIGN UP"),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You have an account ?",
                    style: TextStyle(
                      fontSize: 17,
                    ),),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text("Login !", style:
                        TextStyle(
                          fontSize: 17
                        )
                        ,),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
