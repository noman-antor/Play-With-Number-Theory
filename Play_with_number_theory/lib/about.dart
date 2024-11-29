import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class about extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      title: Text("About Us", style: TextStyle(color: Colors.black,fontFamily: "Times New Roman",
      fontSize: 20,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black),
      body: Center(
        child: Container(
        width: 350,
        height: 570,
        color: Colors.white,
          child:Text("Play With Number Theory is a game which is developed using math concepts. To play this"
    " game, every user must have an account. This account should be unique. Simply, one username"
    " for one player. No two players can have a same username as well as email. If user already have"
    " an account, then he/she has to login using their username and password. There is also an option"
    " to reset the password using email address. After login, user goes to his main profile. On that"
    " page, there are five levels which have locked/unlocked state according to user progress .They can"
    " play levels that they are already successfully completed. The levels that are not completed yet,"
    " remains locked. When a level successfully complete, then score is updated and user can easily "
    " play the next locked level. There is no score count for unlocked levels. Colors of the profile are"
    " updated simultaneously. From user profile, user can see the ranks of the players by pressing see ranks button."
              "\n\n\nDeveloper Contact \n"
            "lammim183856@gmail.com\n"
            "zuhaernoman@gmail.com\n"
            "kapriyan270@gmail.com\n "
          ,style: TextStyle(fontFamily: "Times New Roman", fontSize: 16,),textAlign: TextAlign.justify,),

      ),
      )


    );
  }

}