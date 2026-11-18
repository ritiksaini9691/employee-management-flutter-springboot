import 'package:flutter/material.dart';
import 'package:nov14/AddScreen.dart';
import 'package:nov14/DisplayScreen.dart';
import 'package:nov14/EditScreen.dart';

Widget MyDrawer(BuildContext context)
{
  return Drawer(
    child: Column(
      children: [
        Expanded(child: Container(color: Colors.grey.shade300,),flex: 2,),
        Expanded(child: Container(color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen()));
                },
                title: Text("Add Employee"),
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen()));
                },
                title: Text("Display Employee"),
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScreen()));
                },
                title: Text("Edit Employee"),
              ),
            ],
          ),
        ),flex: 8,)
      ],
    ),
  );
}