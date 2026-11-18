import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nov14/DisplayScreen.dart';
import 'package:nov14/Widget/MyDrawer.dart';
class AddScreen extends StatelessWidget {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  Future<void>save()async
  {
    final url="http://localhost:8080/add";
    var response=await http.post(
      Uri.parse(url),
      headers: {"Content-type":"application/json"},
      body: jsonEncode({
        "name" : t1.text,
        "age" : int.parse(t2.text),
        "salary" : int.parse(t3.text),
      })
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Screen",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: t1,decoration: InputDecoration(hintText: "Enter Name",border: OutlineInputBorder()),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: t2,decoration: InputDecoration(hintText: "Enter Age",border: OutlineInputBorder()),
            ),
            SizedBox(height: 5,),
            TextField(
              controller: t3,decoration: InputDecoration(hintText: "Enter Salary",border: OutlineInputBorder()),
            ),
            SizedBox(height: 5,),
            ElevatedButton(onPressed: (){
              save();
              t1.text="";
              t2.text="";
              t3.text="";
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
