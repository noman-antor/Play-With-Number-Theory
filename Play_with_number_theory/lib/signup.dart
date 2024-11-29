import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'datamodel.dart';
import 'database.dart';
import 'level.dart';


class signup extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _signup();
  }
}

class _signup extends State<signup>
{
  final TextEditingController fname=TextEditingController();
  final TextEditingController lname=TextEditingController();
  final TextEditingController username=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController date=TextEditingController();

  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
    primary: Colors.white,
    onPrimary: Colors.black,
    fixedSize: Size(100, 30),
    textStyle: TextStyle(fontFamily: "Times New Roman",fontWeight: FontWeight.bold),

  );
  int correction_code=0;
  int email_correction=0;

  //check the email
  int check_mail(String x)
  {
    if(x.endsWith("@gmail.com"))
      {
        return 1;
      }
    else
      {
        return 0;
      }
  }
  Color return_color(int x)
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

  //return a text for password correction
  String return_helpertext(int x)
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

  //return if applied password constraints are correct then 1 else 0 for selecting color and signup
  int check_password(String check_pass) {
    int special_char = 0;
    int number = 0;
    if (check_pass.length >= 8)
    {
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
    //if password is not more than 8
    else
      {
        setState(() {
          correction_code=0;
        });
        return 0;
      }
  }
  Future<void> additem() async {
    var result = await Dbprovider.read(username.text);//null(unique)
    var email_result=await Dbprovider.read_email(email.text); //not null(not unique)
    if((result != null && result.length>0) || (email_result != null && email_result.length>0) )
      {
        final snackBar=SnackBar(content:Text("This Username or Email is already in used",
            style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: "UNDO",
            onPressed: (){},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

        else
          {
            if(correction_code==1 && email_correction==1)
              {
                await Dbprovider.addItem(fname.text,
                    lname.text, username.text,email.text,password.text, date.text, "0","0","0");
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(
                    username.text,
                    "0",
                    "0",
                    "0")));
              }
            else
              {
                final snackBar=SnackBar(content:Text("Password or Email Contraints Must Be Followed",
                    style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                  backgroundColor: Colors.white,
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: (){},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
          }
  }



  /*void deletedata() async
  {
    await Dbprovider.deleteall();
    print("Information deleted");
  }*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child:SingleChildScrollView(
          child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100),
            Text("ACCOUNT CREATION",style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: "Times New Roman",fontWeight:FontWeight.bold )),
            SizedBox(height: 40),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("FIRST NAME :",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),

                SizedBox(
                  width: 250,
                  child: TextField(
                    controller: fname,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel), onPressed: () { fname.clear();  },
                      )
                    ),
                  ),
                )
              ],
              ),
            ),
            SizedBox(height:15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("LAST NAME :",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),

                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: lname,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel), onPressed: () { lname.clear();  },
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height:15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("USER NAME:",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),

                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: username,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel), onPressed: () { username.clear();  },
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),

            //email container
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("EMAIL :",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),
                SizedBox(width: 18),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: email,
                      style: TextStyle(color: Colors.black),
                      onChanged: (email){
                        setState(() {
                          email_correction=check_mail(email);
                        });

                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: return_color(email_correction),width: 3)),
                        hintText: "example@gmail.com",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.cancel),
                          color: return_color(email_correction),
                          onPressed: (){
                            email.clear();
                          },
                        )

                      ),

                    ),
                  )
                ],
              )
            ),



            SizedBox(height:15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("PASSWORD :",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: password,
                      onChanged: (val){
                        setState(() {
                          correction_code=check_password(val);
                        });
                        },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          helperText: return_helpertext(correction_code),
                          helperStyle: TextStyle(color: return_color(correction_code)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: return_color(correction_code),width: 3)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            color: return_color(correction_code),
                            onPressed: () { password.clear();  },
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height:15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("BIRTHDATE :",style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: date,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today), onPressed: () {  },
                          ),

                          ),
                        readOnly : true,
                        onTap: () async
                        {
                          DateTime? datechoose=await showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101)
                          );
                          if(datechoose !=null)
                            {
                              String formatteddate=DateFormat('yyyy-MM-dd').format(datechoose);
                                setState(() {
                                  date.text=formatteddate;
                                }
                              );
                            }
                        }
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height:40),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                SizedBox(width: 55),
                //save button
                ElevatedButton(onPressed: (){
                  String f=fname.text;
                  String l=lname.text;
                  String e=email.text;
                  String u=username.text;
                  String p=password.text;
                  String bd=date.text;

                  if(f.isEmpty || l.isEmpty || e.isEmpty|| u.isEmpty || p.isEmpty || bd.isEmpty)
                  {
                    final snackBar= SnackBar(content: const Text("Make sure you have filled all information",
                        style: TextStyle(color: Colors.black,fontFamily: "Times New Roman")),
                        backgroundColor: Colors.white,
                        action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {})
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else
                    {
                      additem();
                    }
                    
                }, child:Text("SAVE"),style: buttonStyle),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child:Text("CANCEL"),style: buttonStyle)
                ],
              ),
            ),
          ],
        ),
      ),
      )
    )
    );
  }
}
