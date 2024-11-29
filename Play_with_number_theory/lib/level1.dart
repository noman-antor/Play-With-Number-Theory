
import 'dart:async';
import 'package:android_projects/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'database.dart';

import 'level.dart';


class level1 extends StatefulWidget
{
  String username="";
  String score="";
  String level_gain="";
  String status="";

  level1(String username,String score,String level_gain,String status)
  {
    this.username=username;
    this.score=score;
    this.level_gain=level_gain;
    this.status =status;
  }
  @override
  level_1 createState()=> level_1();

}
class level_1 extends State<level1>
{
  String ap="";
 Timer? timer;
 int maxsec_bits=1800;
 int sec_bits=1800;
 int minutes=30;
 int seconds=00;

 int scoretime=1800;
 int max_score=500;

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

  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
    textStyle: TextStyle(fontSize: 20),
    backgroundColor: Colors.black,
    fixedSize: Size(150,50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40)))
  );
  final _textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: 40),
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
                        Text("LEVEL 1",style: TextStyle(color: Colors.white,fontFamily: "Times New Roman",fontSize: 30,fontWeight: FontWeight.bold)),
                        SizedBox(width: 150),
                        buildtimer()
                      ],
                    ),
                  ),
                  set_scoretext()
                ]
              )
            ),
            SizedBox(height: 8),
            Container(
              width: 342,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Text("A permutation of length n is an array p=[p1,p2,…,pn],which contains every integer from 1 to n (inclusive) and, moreover, each number appears exactly once."
                  "\n\nFor example, p=[3,1,4,2,5] is a permutation of length 5."
                  "Formally, find such permutation p that 2≤|pi−pi+1|≤4 for each i(1≤i<n).If there are several such permutations, then print any of them."
                  "\nIf Input n=4"
                  "\nThen Output will be: 2 4 1 3 "
                  "\nYou have to find the answer for n=10 within 3 minutes."
                  "\nPenalty for every wrong submission is 100"
                  ,style: TextStyle(color: Colors.white,fontSize: 16,fontFamily:"Times New Roman"),textAlign: TextAlign.justify),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _textcontroller,
              decoration: InputDecoration(
                hintText: "Your answer",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: (){
                    _textcontroller.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Submit Button
                  ElevatedButton(onPressed: ()
                  {
                    ap=_textcontroller.text;
                    List<int> arr=[20];
                    int x=ap.length;
                    int y=0;

                    for(int i=0;i<x;i++)
                    {
                      if(ap[i] !=" ")
                        {
                          y=y*10+int.parse(ap[i]);
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

                    int wrong=0;
                    int permutation_fault=0;
                    if(arr.length==11)
                    {
                      for (int i = 1; i < arr.length - 1; i++)
                      {
                        for (int j = i + 1; j < arr.length; j++)
                        {
                          if (arr[i] == arr[j]) {
                            permutation_fault = 1;
                            break;
                          }
                        }
                        if (permutation_fault == 1)
                        {
                          break;
                        }
                      }
                      if (permutation_fault == 1) {
                        showrejected(context);
                        max_score = max_score - 100;
                      }
                      else {
                        for (int i = 1; i < (arr.length - 1); i++) {
                          int x = (arr[i] - arr[i + 1]).abs();

                          if (x >= 2 && x <= 4) {
                            wrong = 0;
                          }
                          else {
                            wrong++;
                            break;
                          }
                        }
                        if (wrong > 0) {
                          showrejected(context);
                          max_score = max_score - 100;
                        }
                        else {
                          int level_gain_toint = int.parse(widget.level_gain);
                          int score_toint = int.parse(widget.score);
                          if (level_gain_toint < 1) {
                            String newsc = (score_toint + max_score).toString();
                            if ((score_toint + max_score) < score_toint) {
                              Dbprovider.updateinfo(
                                  widget.username, "1", newsc, "-1");
                              timer?.cancel();
                              showaccepted(context);
                            }
                            else {
                              Dbprovider.updateinfo(
                                  widget.username, "1", newsc, "0");
                              timer?.cancel();
                              showaccepted(context);
                            }
                          }
                          else {
                            timer?.cancel();
                            showaccepted(context);
                          }
                        }
                      }
                      }

                    else {
                      showrejected(context);
                      max_score = max_score - 100;
                    }

                  }, child: Text("Submit"),style: buttonStyle),

                  //cancel button
                  SizedBox(height: 15),
                  ElevatedButton(onPressed: (){
                    timer?.cancel();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                        widget.score,widget.level_gain,"-1")));
                  }, child: Text("Cancel"),style: buttonStyle),
                ]
              )
            )
          ]
        )
      )
    )
    );
  }

  showaccepted(BuildContext context)
  {
    int level_gain_toint=int.parse(widget.level_gain);
    showDialog(context: context, builder: (BuildContext context){
      if(level_gain_toint<1)
        {
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            content: Text("Achieved score is $max_score & you successfully unlocked LEVEL 2"),
            actions: <Widget>[
              ElevatedButton(onPressed:()
              {
                int score_toint = int.parse(widget.score);
                String next_score=(score_toint+max_score).toString();
                if((score_toint+max_score)<score_toint)
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                      next_score, "1","-1")));
                  }
                else
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                      next_score, "1","0")));
                  }

                }, child: Text("Proceed"))
            ],
          );

        }
      else
        {
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            actions: <Widget>[
              ElevatedButton(onPressed:()
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username,
                  widget.score,widget.level_gain,widget.status)));
              }, child: Text("Proceed"))
            ],
          );
        }

    }
    );
  }

  showrejected(BuildContext context)
  {
    int level_gain_toint=int.parse(widget.level_gain);
    showDialog(context: context, builder: (BuildContext context){
      if(level_gain_toint<1)
        {
            return AlertDialog(
              title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
              content: Text("Your Score is decremented by 100"),
              actions: <Widget>[
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Continue"))
              ],
            );
        }
      else
        {
            return AlertDialog(
              title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Continue"))
              ],
            );
        }

    }
   );
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

  Widget set_scoretext()
  {
    int level_gain_toint=int.parse(widget.level_gain);
    if(level_gain_toint<1)
      {
        if(sec_bits==(scoretime-300))
        {
          scoretime=sec_bits;
          max_score=max_score-50;
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
  Widget buildtimer()=> SizedBox(
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

}
