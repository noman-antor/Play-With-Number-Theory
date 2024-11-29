import 'package:android_projects/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'level.dart';
import 'login.dart';

class sp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      fixedSize: Size(200, 50),
      textStyle: TextStyle(fontFamily: "Times New Roman",fontSize: 20,fontWeight: FontWeight.bold),
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))
      )
    );
    return Scaffold(

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text("         Play With \n \t Number Theory",
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25))
          ),
        ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed:()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
            },
                child: Text("Start Game"),style: buttonStyle),
            SizedBox(height: 5),

            ElevatedButton(onPressed:()
            {

            }, child: Text("About"),style: buttonStyle),
            SizedBox(height: 5),
            ElevatedButton(onPressed:()
            {
              SystemNavigator.pop();
            }, child: Text("Exit"),style: buttonStyle),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

}