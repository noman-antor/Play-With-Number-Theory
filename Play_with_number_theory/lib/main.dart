import 'dart:async';
import 'dart:ui';
import 'package:android_projects/login.dart';
import 'package:android_projects/sp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    debugShowCheckedModeBanner: false,
    );
  }
}
class Homepage extends StatefulWidget
{
  @override
  Homepagestate createState() => Homepagestate();
}
class Homepagestate extends State<Homepage>
{
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds:5),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>login()));
      },
    );
}


@override
Widget build(BuildContext context) {
return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/brain.jpg"),
            fit: BoxFit.cover
        ),
      ),
      child: Center(
        child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("BRAIN HUNGER",
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text("Lets Rock With Number Theory",
                  style: TextStyle(
                    fontFamily: "Times New Roman",
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),

              ]
          )
        ),
      ),
    ),
  );
  }
}



