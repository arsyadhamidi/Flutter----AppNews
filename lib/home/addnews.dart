import 'dart:developer';
import 'dart:io';

import 'package:appnews/constantfile/constantfile.dart';
import 'package:appnews/global/dataglobal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {

  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  TextEditingController _description = TextEditingController();

  PickedFile? _imageFile;

  Future<String?> validasiAddNews() async{
    if(_key.currentState!.validate()){
      if(_title.text.isEmpty || _content.text.isEmpty || _description.text.isEmpty){
        print("Data is cannot be empty");
      }else{
        final uri = Uri.parse(ConstantFile.url + "addnews.php");
        var request = http.MultipartRequest('POST', uri);
        request.files.add(
            http.MultipartFile.fromBytes(
                'image',
                File(_imageFile?.path ?? '').readAsBytesSync(),
                filename: _imageFile?.path.split("/").last
            )
        );
        request.fields['title'] = _title.text;
        request.fields['content'] = _content.text;
        request.fields['description'] = _description.text;
        request.fields['id_users'] = dataGlobal?.user?.data?.idUsers ?? '';
        var res = await request.send();
        log(res.toString());
        Navigator.pop(context);
        return res.reasonPhrase;
      }
    }
  }

  Future<void> pilihGalery() async{
    try{
      var image = await ImagePicker.platform.pickImage(
          source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920
      );
      setState(() {
        _imageFile = image!;
      });
    }catch(exp){
      print(exp);
    }
  }

  @override
  Widget build(BuildContext context) {

    var placeholder = Container(
      width: double.infinity,
      height: 150,
      child: Image.asset("assets/images/foto-profile.png"),
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Add News"),
        ),
      ),
      body: Form(
        key: _key,
          child: Padding(
              padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: InkWell(
                    onTap: (){
                      pilihGalery();
                    },
                    child: _imageFile == null ? placeholder :
                    Image.file(File(_imageFile?.path ?? ''), fit: BoxFit.fill,),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    hintText: "Enter your title..",
                    prefixIcon: Icon(CupertinoIcons.doc_plaintext),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )
                  ),
                  validator: (t){
                    if(t!.isEmpty){
                      return "Data is cannot be empty";
                    }
                    if(t.trim().length < 5){
                      return "Title minimal 5 Character";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _content,
                  decoration: InputDecoration(
                      hintText: "Enter your content..",
                      prefixIcon: Icon(CupertinoIcons.doc_plaintext),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      )
                  ),
                  validator: (c){
                    if(c!.isEmpty){
                      return "Data content is cannot be Empty";
                    }
                    if(c.trim().length < 5){
                      return "Content Minimal 5 Character";
                    }
                    else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _description,
                  decoration: InputDecoration(
                      hintText: "Enter your description..",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                  ),
                  maxLines: 8,
                  validator: (d){
                    if(d!.isEmpty){
                      return "Data Description is cannot be Empty";
                    }
                    if(d.trim().length < 5){
                      return "Description minimal 5 Character";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      validasiAddNews();
                    },
                    child: Text("Add News"),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
