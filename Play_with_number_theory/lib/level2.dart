import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database.dart';
import 'level.dart';

class level2 extends StatefulWidget
{
  String username="";
  String score="";
  String level_gain="";
  String status="";

  level2 (String username,String score,String level_gain,String status)
  {
    this.username= username;
    this.score = score;
    this.level_gain = level_gain;
    this.status = status;
  }
  @override
  State<StatefulWidget> createState()=> level_2();

}
class level_2 extends State<level2>
{
  int maxsec_bits=1800;
  int sec_bits=1800;
  int minutes=30;
  int seconds=00;

  int scoretime=1800;
  int max_score=800;
  Timer? timer;
  final takeinput=TextEditingController();
  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    fixedSize: Size(150, 50),
    textStyle: TextStyle(fontSize: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
  );
  @override
  void initState() {
    // TODO: implement initState
    starttime();
  }

  void starttime()
  {
    timer=Timer.periodic(Duration(seconds: 1), (_) {
      if(seconds>0)
      {
        setState(() {
          seconds--;
          sec_bits--;
        });
      }
      else if(minutes>0 && seconds==0)
      {
        setState(() {
          minutes--;
          seconds=59;
          sec_bits--;
        });
      }
      else
      {
        timer?.cancel();
        Timeisup(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Container(
        child:SingleChildScrollView(
        child: Column(
          children: [

            Container(
                width: double.infinity,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.black
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Text("LEVEL 2",style: TextStyle(color: Colors.white,fontFamily: "Times New Roman",fontSize: 30,fontWeight: FontWeight.bold)),
                          SizedBox(width: 150),
                          buildtimer()
                        ],
                      ),
                    ),
                    setscoretext()
                  ],
                )
            ),
            SizedBox(height: 8),
            Container(
              width: 342,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Text("A 0-indexed array a of size n is called good if for all valid indices i(0<=i<=n-1),a(i)+i is a perfect square\n"
                "Find a permutation p that is good or determine that no such permutation exists"
                  "\nIf input n is given 3"
                  "\nThen output will be 1 0 2"
                  "\n"
                  "\nYou have to find permutation for n=7"
                  "\nFor every wrong submission, your score is downed by 150",
                style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Times New Roman"),textAlign: TextAlign.justify),
            ),
            SizedBox(height: 10),
            TextField(
              controller:takeinput,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your Answer",
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: ()
                  {
                    takeinput.clear();
                  },
                )
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //submit button
                  ElevatedButton(onPressed: (){
                    String getanswer=takeinput.text;
                    List <int> arr=[100];
                    int x=getanswer.length;
                    int y=0;
                    //getting string into int type arraylist
                        for(int i=0;i<x;i++)
                        {
                          if(getanswer[i] !=" ")
                          {
                            y=y*10+int.parse(getanswer[i]);
                            if(i==(x-1))
                            {
                              arr.add(y);
                            }
                          }
                          else
                          {
                            arr.add(y);
                            y=0;
                          }
                        }
                        /*for(int i=1;i<arr.length;i++)
                      {
                        print(arr[i]);
                      }*/
                    if(arr.length == 8)
                      {
                        int k=0;
                        int a=0;
                        int c=0;
                        int d=0;
                        for(int i=1;i<arr.length;i++)
                        {
                          a=arr[i]+k;
                          double b=sqrt(a);
                          k++;
                          d=b.toInt();
                          if(d*d==a)
                          {

                          }
                          else {
                            c = 1;
                            break;
                          }
                        }

                        if(c==1)
                        {
                          showrejected(context);
                          max_score=max_score-150;

                        }
                        else
                        {
                          int level_gaintoint=int.parse(widget.level_gain);
                          if(level_gaintoint<2)
                            {
                              int score_toint=int.parse(widget.score);
                              String score=(score_toint+max_score).toString();
                              if((score_toint+max_score)<score_toint)
                                {
                                  Dbprovider.updateinfo(widget.username, "2", score,"-1");
                                  timer?.cancel();
                                  showaccepted(context);

                                }
                              else
                                {
                                  Dbprovider.updateinfo(widget.username, "2", score,"0");
                                  timer?.cancel();
                                  showaccepted(context);

                                }

                            }
                          else
                            {
                              timer?.cancel();
                              showaccepted(context);

                            }

                        }

                      }

                    else
                      {
                        showrejected(context);
                        max_score=max_score-150;
                      }


                  }, child: Text("Submit"),style: buttonStyle),

                  //cancel button
                  ElevatedButton(onPressed: (){
                    timer?.cancel();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                      widget.score,widget.level_gain,"-1")));
                  }, child: Text("Cancel"),style: buttonStyle),
                ],
              ),
            ),
            SizedBox(height: 35),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setscoretext()
                ],
              ),
            ),

          ],
        ),
      )
      )
    );
  }

  Widget buildtimer()=>
      SizedBox(
    height: 50,
    width: 70,
    child:Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
            value: sec_bits/maxsec_bits,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 6,
            backgroundColor:Colors.black
        ),
        Center(child: buildtime())
      ],
    ) ,
  );
  Widget buildtime()
  {
    return Text("$minutes:$seconds",style: TextStyle(color: Colors.white,fontSize: 20),);
  }

  Widget setscoretext()
  {
    int level_gaintoint=int.parse(widget.level_gain);
    if(level_gaintoint<2)
      {
        if(sec_bits == scoretime-300)
        {
          max_score=max_score-180;
          scoretime=sec_bits;
          return Text("  Remaining Score: $max_score",style: TextStyle(fontSize: 20,color: Colors.white));
        }
        else
        {
          return Text("  Remaining Score: $max_score",style: TextStyle(fontSize: 20,color: Colors.white));
        }

      }
    else
      {
        return Text("  Remaining Score: 0",style: TextStyle(fontSize: 20,color: Colors.white));
      }

  }

  showaccepted(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain);
    if(level_gaintoint<2)
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            content: Text("Achieved Score: $max_score & You Successfully Unlocked Level 3"),
            actions: <Widget>[
            ElevatedButton(onPressed: (){
                int score_toint=int.parse(widget.score);
                String newscore=(score_toint+max_score).toString();
                if((score_toint+max_score)<score_toint)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                        newscore,"2","-1")));
                  }
                else
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                        newscore,"2","0")));
                  }

              }, child: Text("Proceed"))
            ],
          );
        });

      }
    else
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                  widget.score,widget.level_gain,widget.status)));
              }, child: Text("Proceed"))
            ],
          );
        });
      }
  }

  showrejected(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain);
    if(level_gaintoint<2)
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
            content: Text("Your maximum score is decremented by 150"),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Continue"))
            ],
          );
        });

      }
    else
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Continue"))
            ],
          );
        });
      }

  }

  Timeisup(BuildContext context)
  {
    showDialog(context: context, builder: (BuildContext comtext)
    {
      return AlertDialog(
        title: Text("Time is UP!!!!!!!!!!!!!!!",style: TextStyle(color: Colors.red)),
        actions: <Widget>[
          ElevatedButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                widget.score,widget.level_gain,widget.status)));
          }, child:Text("EXIT"))
        ],
      );
    }
    );
  }

}