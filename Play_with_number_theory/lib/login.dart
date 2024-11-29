import 'package:android_projects/level.dart';
import 'package:android_projects/showrank.dart';
import 'package:android_projects/signup.dart';
import 'package:android_projects/sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'about.dart';
import 'datamodel.dart';
import 'database.dart';
import 'forget_pass.dart';

class login extends StatefulWidget
{
  final TextEditingController userinput=TextEditingController();
  final TextEditingController idinput=TextEditingController();
  @override
  State<StatefulWidget> createState()=> _login();

}

class _login extends State<login>
{
  bool passwordVisible = true;
  @override
  void initState()
  {
    super.initState();
    passwordVisible = true;
  }
  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle=ElevatedButton.styleFrom(
      primary: Colors.white, //outside field of button
      onPrimary: Colors.black, //inside field of button
      textStyle: TextStyle(fontFamily: "Times New Roman",fontWeight: FontWeight.bold),
      fixedSize: Size(131, 30),
    );
    Future<void> enter() async
    {
      var password=await Dbprovider.read(widget.userinput.text);
      if(password != null && password.length>0)
      {
        String x=password[0].password;//password coming from database
        String y=widget.idinput.text;//password specified by user in UI

        String un= password[0].username;
        String sc= password[0].score;
        String lvl= password[0].level;
        String stat=password[0].score_status;

        if(x == "$y")
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> level(un, sc, lvl,stat)));
        }
        else
          {
            final snackBar=SnackBar(content: Text("Wrong Password",
                style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                backgroundColor: Colors.white,
                action: SnackBarAction(
                  label: "UNDO",
                  onPressed: (){},
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
      }
      else
        {
          final snackBar=SnackBar(content: Text("Please Enter Valid ID or Username",
          style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: "UNDO",
            onPressed: (){},
          ));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    }

    return Scaffold(
      body: Container(color: Colors.black,
        child: Center(
          child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //exit button
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 300),
                    FloatingActionButton(onPressed: (){
                      showexit(context);
                      },child: Icon(Icons.cancel,color: Colors.white,size: 40),backgroundColor:Colors.black,
                      splashColor: Colors.white,
                    )
                  ],
                ),
              ),//exit button code ends
              SizedBox(height: 40),
              Text("Welcome Back",style: TextStyle(fontSize: 50,color: Colors.white,fontFamily:"Times New Roman" )),
              SizedBox(height: 10),
              //username
              TextField(
                  controller:widget.userinput,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(),
                      hintText: "User Name",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: ()
                        {
                          widget.userinput.clear();
                        },
                      )
                  ),
                ),
              SizedBox(height: 5),
              //password
              TextField(
                controller: widget.idinput,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: UnderlineInputBorder(),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                          () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
              ),
            ),
          SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>forget_pass()));
                      },
                      child: Text("Forget Password !",style: TextStyle(color: Colors.white,
                          fontFamily: "Times New Roman",fontSize: 16)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                enter();
              }, child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("LOG IN"),
                      SizedBox(width: 10),
                      Icon(Icons.login),
                    ]
                  ),
                ),
                style: buttonStyle,
              ),

              SizedBox(height: 50),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account?",style: TextStyle(color: Colors.white,fontFamily: "Times New Roman",fontSize: 30)),
                    SizedBox(height: 10),
                    ElevatedButton(onPressed: () { 
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> signup()));
                    }, child: Text("SIGN UP NOW"),style:buttonStyle,)
                  ]
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: GestureDetector(
                  child:
                      Text("About Us",style: TextStyle(fontFamily: "Times New Roman",color: Colors.white,
                      decoration:TextDecoration.underline,
                      fontSize: 18),),
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> about()));
                  }
                ),
              )
            ],
          ),
        ),
      )
    )
    );
  }
  showexit(BuildContext context)
  {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text("Are you sure want to Exit?",style: TextStyle(color: Colors.black,
      fontFamily: "Times New Roman",fontSize: 20),),
      icon: Icon(Icons.android_outlined,size: 50),
      content: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child:Text("Yes",style: TextStyle(color: Colors.black,
                  fontFamily: "Times New Roman",fontSize: 20)),
              onTap: (){
                SystemNavigator.pop();
              },
            ),
            GestureDetector(
              child:Text("No",style: TextStyle(color: Colors.black,
                  fontFamily: "Times New Roman",fontSize: 20)),
              onTap: (){
                Navigator.of(context).pop();
              },
            )
          ]
        ),
      ),);
    });
  }

}