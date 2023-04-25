import 'dart:convert';

import 'package:appnews/global/dataglobal.dart';
import 'package:appnews/home/datanews.dart';
import 'package:appnews/model/modeluser.dart';
import 'package:appnews/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key);

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {

  int _selectIndex = 0;

  void selectIndex(int index) async{
    setState(() {
      _selectIndex = index;
    });
  }

  static List<Widget> selectBody = <Widget>[
    HomePage(),
    DataNews(),
    Text("Page 3"),
    Text("Page 4"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Udacoding"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Center(child: selectBody.elementAt(_selectIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: selectIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_chart_fill),
            label: "News",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.archivebox_fill),
              label: "More",
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle),
              label: "Account",
          )
        ],
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var users = prefs.getString("dataUser");
    print(jsonDecode(users ?? ''));
    setState(() {
      dataGlobal.user = modelUserFromJson(users ?? '');
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Berhasil Login!"),
            Center(
              child: Text(dataGlobal.user?.data?.email ?? '')),
            Text(dataGlobal.user?.data?.username ?? ''),
            MaterialButton(
              color: Colors.blue,
              onPressed: (){
                NetworkProvider().logoutUser(context);
              },
              child: Text("LOGOUT", style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
