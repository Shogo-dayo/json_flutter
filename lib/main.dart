import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

main(){
  runApp(new AppName());
}

class AppName extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return AppState();
  }
}

class AppState extends State<AppName>{

  String name = "";
  int id = 0;
  int public_repos = 0;
  TextEditingController user = TextEditingController();
  String url = "https://api.github.com/users/";

  getData(String username) async{
    String profile = url +  username;
    var res = await http.get(profile,headers:{"Accept":"application/json"});
    var resBody = json.decode(res.body);
    name = resBody["name"];
    id = resBody["id"];
    public_repos = resBody["public_repos"];
    setState(() {
      print("success");
    });
  }


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("JSON App"),
        ),
        body : Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              TextField(
                controller: user,
                decoration: InputDecoration(hintText: "Enter Github UserName"),

              ),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              RaisedButton(
                  onPressed: () => getData(user.text),
                  child: Text("Get info")
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Text("Name: $name"),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text("ID: $id"),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text("Public repo: $public_repos")
            ],
          )
        )
      )
    );
  }
}
