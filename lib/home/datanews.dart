import 'dart:convert';

import 'package:appnews/constantfile/constantfile.dart';
import 'package:appnews/global/dataglobal.dart';
import 'package:appnews/home/addnews.dart';
import 'package:appnews/home/editnews.dart';
import 'package:appnews/home/home.dart';
import 'package:appnews/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/modelnews.dart';

class DataNews extends StatefulWidget {
  const DataNews({Key? key}) : super(key: key);

  @override
  State<DataNews> createState() => _DataNewsState();
}

class _DataNewsState extends State<DataNews> {

  List<ModelNews>? listNews;

  Future<List<ModelNews>?> listDataNews() async{
    try{
      List<ModelNews> response = await NetworkProvider().getDataNews();
      setState(() {
        listNews = response;
      });
    }catch(exp){}

    return listNews;

  }

  Future<List<ModelNews>?> hapusNews(String? idNews) async{
    try{
      final response = await http.post(Uri.parse(ConstantFile.url + "deletenews.php"),
          body: {
        "id_news": idNews,
      });
      List<ModelNews> hapusdataNews = await modelNewsFromJson(response.body);
      if(hapusdataNews == 200){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuHome()));
        print("Data Delete Successfully");
        return hapusdataNews;
      }else{
        print("Data Is Not Delete Successfully");
      }
    }catch(exp){}
  }

  @override
  void initState() {
    listDataNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: listNews?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  MaterialButton(
                    onPressed: (){},
                    child: Container(
                      height: 200,
                      child: Expanded(
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                    "${ConstantFile.url + "upload/"}${listNews?[index].image ?? ''}",
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress != null) {
                                        return CircularProgressIndicator();
                                      } else {
                                        return child;
                                      }
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: Container(
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(listNews?[index].title ?? '',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      Text(listNews?[index].content ?? ''),
                                      SizedBox(height: 15),
                                      Text(
                                        listNews?[index].description ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        MaterialButton(
                          color: Colors.red,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditNews(
                              model: ModelNews(
                                idNews: listNews?[index].idNews,
                                image: listNews?[index].image,
                                title: listNews?[index].title,
                                content: listNews?[index].content,
                                description: listNews?[index].description,
                              ),
                            )));
                          },
                          child: Text("Update News ${listNews?[index].idNews ?? ''}", style: TextStyle(color: Colors.white),),
                        ),
                        SizedBox(width: 10),
                        MaterialButton(
                          color: Colors.orange,
                          onPressed: (){
                            hapusNews(listNews?[index].idNews ?? '');
                          },
                          child: Text("Delete News ${listNews?[index].idNews ?? ''}", style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNews()));
        },
        child: Icon(CupertinoIcons.plus),
      ),
    );
  }
}
