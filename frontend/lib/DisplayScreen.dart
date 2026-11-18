import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nov14/Widget/MyDrawer.dart';
class DisplayScreen extends StatefulWidget {

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {

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

  void remove(int id)async
  {
    var response=await http.get(Uri.parse("http://localhost:8080/delete/${id}"));
    if(response.statusCode==200)
      {
        getData();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Display All Employee",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder:(context,index)=>Card(
            child: ListTile(
              leading: CircleAvatar(child: Text("${data[index]['name'][0].toString().toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
              title: Text(data[index]['name']),
              subtitle: Text("Age :${data[index]['age']} And Salary :${data[index]['salary']}"),
              trailing: IconButton(onPressed: (){
                remove(data[index]['id']);
              }, icon: Icon(Icons.delete)),
            ),
          )
      ),
    );
  }
}
