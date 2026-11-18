import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nov14/Edit.dart';
import 'package:nov14/Widget/MyDrawer.dart';
class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  List<Map<String,dynamic>>data=[];
  void getData()async
  {
    List<dynamic>temp=[];
    var response=await http.get(Uri.parse("http://localhost:8080/employees"));
    temp=jsonDecode(response.body);
    setState(() {
      data=temp.cast<Map<String,dynamic>>();
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Edit Screen",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder:(context,index)=>Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(data[index]['name'][0].toString().toUpperCase()),),
              title: Text(data[index]['name']),
              subtitle: Text("Age :${data[index]['age']} And Salary :${data[index]['salary']}"),
              trailing: IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Edit(data[index]['id'])));
              }, icon: Icon(Icons.edit)),
            ),
          )
      ),
    );
  }
}
