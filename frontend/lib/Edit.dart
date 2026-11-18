import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nov14/DisplayScreen.dart';
class Edit extends StatefulWidget {
  int id=0;
  Edit(int id)
  {
    this.id=id;
  }

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  Future<void>loadData()async
  {
    var response=await http.get(Uri.parse("http://localhost:8080/getById/${widget.id}"));
    Map<String,dynamic>data=jsonDecode(response.body);
    t1.text=data['name'];
    t2.text=data['age'].toString();
    t3.text=data['salary'].toString();
  }
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void update()async
  {
    Map<String,dynamic>data={"id":widget.id,"name":t1.text,"age":t2.text,"salary":t3.text};
    var response=await http.post(Uri.parse("http://localhost:8080/add"),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(data)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Edit Employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: t1,decoration: InputDecoration(border: OutlineInputBorder()),
            ),SizedBox(height: 5,),
            TextField(
              controller: t2,decoration: InputDecoration(border: OutlineInputBorder()),
            ), SizedBox(height: 5,),
            TextField(
              controller: t3,decoration: InputDecoration(border: OutlineInputBorder())
            ),SizedBox(height: 5,),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  update();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DisplayScreen()));
                }, child: Text("update Information")),
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DisplayScreen()));
                }, child: Text("Go Back"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
