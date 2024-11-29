import 'package:android_projects/database.dart';
import 'package:android_projects/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database.dart';
import 'level.dart';
import 'login.dart';

class forget_pass extends StatefulWidget
{
  final TextEditingController email=TextEditingController();
  final TextEditingController pass=TextEditingController();
  @override
  State<StatefulWidget> createState()=>_forget_pass();


}
class _forget_pass extends State<forget_pass>
{
  int correction_code=0;

  String return_helper_text(int x)
  {
    if(x==1)
    {
      return "Constraints Matched";
    }
    else
    {
      return "Constraints: 8 digits long with a number\nand special Character (@,#,\$,%?)";
    }
  }
  //return color for accurate password
  Color return_helper_style(int x)
  {
    if(x==1)
    {
      return Colors.blue;
    }
    else
    {
      return Colors.red;
    }
  }
  //checking new password
  int check_password(String check_pass) {
    int special_char = 0;
    int number = 0;
    print(check_pass.length);
    if (check_pass.length >= 8)
    {
      print("yes");
      for (int i = 0; i < check_pass.length; i++) {
        if (check_pass[i] == "@" || check_pass[i] == "\$" ||
            check_pass[i] == "#" || check_pass[i] == "%" ||
            check_pass[i] == "?"||check_pass[i] == "&") {
          special_char++;
          break;
        }
      }
      for (int i = 0; i < check_pass.length; i++)
      {
        for (int j = 0; j <= 9; j++)
        {
          if (check_pass[i] == "$j")
          {
            number++;
            break;
          }
        }
        if (number == 1) {
          break;
        }
      }
      if (number == 1 && special_char == 1) {
        setState(() {
          correction_code=1;
        });
        return 1;
      }
      else {
        setState(() {
          correction_code=0;
        });
        return 0;
      }
    }
    else
    {
      setState(() {
        correction_code=0;
      });
      return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: double.infinity,
        width: double.infinity,
      child:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 150,),
            Text("Email?",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Times New Roman"),),
            SizedBox(height: 5),
            TextField(
              controller: widget.email,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: "example@gmail.com",
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: (){
                    widget.email.clear();
                  },
                )
              ),
            ),
            SizedBox(height: 20),
            Text("Set_Password",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Times New Roman")),
            SizedBox(height: 5),
            TextField(
              controller: widget.pass,
              onChanged: (val){
                correction_code=check_password(val);
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: return_helper_style(correction_code),width: 3)),
                  filled: true,
                  fillColor: Colors.white,
                  border: UnderlineInputBorder(),
                  helperText:return_helper_text(correction_code),
                  helperStyle:TextStyle(color: return_helper_style(correction_code)) ,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    color: return_helper_style(correction_code),
                    onPressed: (){
                      widget.pass.clear();
                    },
                  )
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  },child: Icon(Icons.cancel)),
                  FloatingActionButton(onPressed: () async{
                    String eml=widget.email.text;
                    String password=widget.pass.text;
                    if(eml.isEmpty || password.isEmpty)
                      {
                        final snackBar=SnackBar(content: Text("Make sure you have filled all information",
                            style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                          backgroundColor: Colors.white,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    else
                      {
                        if(correction_code==1)
                          {
                            var result=await Dbprovider.read_email(eml);
                            if(result != null && result.length>0)
                            {
                              await Dbprovider.password_update(eml, password);
                              set_password(context,eml);
                            }
                            else
                              {
                                final snackBar=SnackBar(content: Text("Your Email do not matched to our database",
                                    style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                                  backgroundColor: Colors.white,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                          }
                        else
                          {
                          final snackBar=SnackBar(content: Text("Invalid New Password",
                          style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                          backgroundColor: Colors.white,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                          }
                    },child: Icon(Icons.archive_outlined),)
                ],
              ),
            )
          ],

        ),
      )
      )
    );
  }

  set_password(BuildContext context,String email)
  {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(title: Text("Password Updated Successfully",style: TextStyle(color: Colors.green,
      fontSize: 20,fontFamily: "Times New Roman",fontWeight: FontWeight.bold),),
      icon:Icon(Icons.where_to_vote,color: Colors.green,size: 30,),
        actions: [
          IconButton(onPressed: () async{
            var result=await Dbprovider.read_email(email);
            String name=result[0].username;
            String lvl=result[0].level;
            String scr=result[0].score;
            String stat=result[0].score_status;
            Navigator.push(context, MaterialPageRoute(builder: (context)=>level(name,scr,lvl,stat)));
          }, icon: Icon(Icons.home))
        ],
      );
    });
  }

}