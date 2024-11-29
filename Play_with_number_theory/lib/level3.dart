import 'dart:async';

import 'package:android_projects/database.dart';
import 'package:android_projects/level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class level3 extends StatefulWidget
{
  String username3="";
  String score3="";
  String level_gain3="";
  String status3="";
  level3(String name,String sc, String levl, String stat)
  {
    this.username3=name;
    this.score3=sc;
    this.level_gain3=levl;
    this.status3=stat;
  }
  @override
  State<StatefulWidget> createState()=> level_3();

}
class level_3 extends State<level3>
{
  int sec_bits=1800;
  int max_score=1200;
  int max_sec=1800;
  int scoretime=1800;

  int min=30;
  int sec=00;
  Timer? timer;

  final TextEditingController take_answer=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    starttime();
  }
 ButtonStyle _buttonStyle=ElevatedButton.styleFrom(
   backgroundColor: Colors.black,
   fixedSize: Size(150, 50),
   textStyle: TextStyle(fontSize: 20),
   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
 );
  void starttime()
  {
    timer=Timer.periodic(Duration(seconds: 1),(_){
      if(sec>0)
        {
          setState(() {
            sec--;
            sec_bits--;
          });
        }
      else if(sec==0 && min>0)
        {
          setState(() {
            min--;
            sec=59;
            sec_bits--;
          });
        }
      else
        {
          timer?.cancel();
          Timesup(context);
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 110,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("LEVEL 3",style: TextStyle(color: Colors.white,
                          fontFamily: "Times New Roman",fontWeight: FontWeight.bold,
                          fontSize: 30),),
                          SizedBox(width: 150),
                          buildtimer()
                        ],
                      ),
                    ),
                    setscore()
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 280,
                width: 342,
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Text("                         [SCROLLABLE TEXT]"
                      "\nRecall that a permutation of length n is an array where each element from 1 to n occurs exactly once."
                      "\nFor a fixed positive integer d, let's define the cost of the permutation p of length n as the number of indices i (1≤i<n)such that pi⋅d=pi+1."
                      "\n \nFor example, if d=3 and p=[5,2,6,7,1,3,4],then the cost of such a permutation is 2, because p2⋅3=p3 and p5⋅3=p6."
                      "\nYour task is the following one: for a given value n, find the permutation of length n and the value d with maximum possible cost (over all ways to choose the permutation and d).\n \nPrint the value d in the first line, and n integers in the second line ."
                      "You have to find permutation for n=30. Remember that, The Penalty for every worng submission is 250",
                      style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Times New Roman"),textAlign: TextAlign.justify),
                )
              ),
              SizedBox(height: 10),
              TextField(
                controller: take_answer,
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: "Your Answer",
                  suffixIcon: IconButton(icon: Icon(Icons.cancel),onPressed: (){
                    take_answer.clear();
                    },)
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      String answer=take_answer.text;
                      List <int> array=[100];
                      int y=0;
                      int permutation_fault=0;

                      for(int i=0;i<answer.length;i++)
                      {
                        if(answer[i] !=" ")
                        {
                          y=y*10+int.parse(answer[i]);
                          if(i==(answer.length-1))
                          {
                            array.add(y);
                          }

                        }
                        else
                        {
                          array.add(y);
                          y=0;
                        }
                      }

                      if(array.length==31)
                        {
                            int a=0;
                            for(int i=0;i<30;i++)
                            {
                              if(array[i]*2==array[i+1]) ///1 2 4 8 3 6 5 10 7 9
                              {
                                a++;
                              }
                              else if(array[i]*2>30)
                              {

                              }
                              else
                              {

                              }
                            }
                            if(30/2==a)
                            {
                              array.sort();
                              for(int i=0;i<29;i++)
                              {
                                if(array[i]==array[i+1])
                                {
                                  showrejected(context);
                                  max_score=max_score-250;
                                  permutation_fault=1;
                                  break;
                                }
                              }
                              if(permutation_fault==0)
                                {
                                  int level_gaintoint = int.parse(widget.level_gain3);
                                  if (level_gaintoint < 3)
                                  {
                                    int score_toint = int.parse(widget.score3);
                                    String score = (score_toint + max_score).toString();
                                    if ((score_toint + max_score) < score_toint) {
                                      Dbprovider.updateinfo(
                                          widget.username3, "3", score, "-1");
                                      timer?.cancel();
                                      showaccepted(context);
                                    }
                                    else {
                                      Dbprovider.updateinfo(
                                          widget.username3, "3", score, "0");
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
                            else
                            {
                              timer?.cancel();
                              showrejected(context);
                            }

                        }
                      else{
                        showrejected(context);
                        max_score=max_score-250;
                      }
                    }, child: Text("Submit"),style: _buttonStyle,),

                    ElevatedButton(onPressed: (){
                      timer?.cancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username3,
                          widget.score3,widget.level_gain3,"-1")));

                    }, child: Text("Cancel"),style: _buttonStyle,)

                  ],
                ),
              )


            ],
          ),
        ),
      ),

    );
  }

  Widget buildtimer()=>SizedBox(
    height: 50,
    width: 70,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: sec_bits/max_sec,
          strokeWidth: 6,
          valueColor: AlwaysStoppedAnimation(Colors.white),
          color: Colors.black,
        ),
        Center(child: buildtime())
      ],
    ),
  );

  Widget buildtime()
  {
    return Text("$min:$sec",style: TextStyle(color: Colors.white,fontSize: 20));
  }

  showaccepted(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain3);
    if(level_gaintoint<3)
      {
        showDialog(context: context, builder:(BuildContext context){
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            content: Text("Achieved Score: $max_score & You Successfully Unlocked Level 4"),
            actions: [
              ElevatedButton(onPressed: (){
                int score3_toint=int.parse(widget.score3);
                int newscore_toint=score3_toint+max_score;
                String newscore=newscore_toint.toString();
                if(newscore_toint<score3_toint)
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username3, newscore,"3","-1")));
                  }
                else
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username3, newscore,"3","0")));
                  }
              }, child: Text("Proceed"))
            ],
          );
        });
      }
    else
      {
        showDialog(context: context, builder:(BuildContext context){
          return AlertDialog(
            title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username3,
                widget.score3,widget.level_gain3,widget.status3)));
                }, child: Text("Proceed"))
            ],
          );
        });
      }
  }
  showrejected(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain3);
    if(level_gaintoint<3)
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
            content: Text("Your maximum score is decremented by 250"),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
          }, child: Text("Continue"))

            ],
          );
        }
        );
      }
    else
      {
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Continue"))
            ],
          );
        }
        );
      }
  }

  Timesup(BuildContext context)
  {
    showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        title: Text("Time is UP!!!!!!!!!!!!!!!",style: TextStyle(color: Colors.red)),
        actions: <Widget>[
          ElevatedButton(onPressed: () {
            timer?.cancel();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username3,
                widget.score3,widget.level_gain3,widget.status3)));
          }, child:Text("EXIT"))
        ],
      );
    });
  }

  Widget setscore()
  {
    int level_gaintoint=int.parse(widget.level_gain3);
    if(level_gaintoint<3)
      {
        if(sec_bits==(scoretime-300))
          {
            scoretime=scoretime-300;
            max_score=max_score-400;
            return Text(
              "Remaining Score : $max_score",style: TextStyle(fontSize: 20,color: Colors.white)
            );
          }
        else
          {
            return Text(
                "Remaining Score : $max_score",style: TextStyle(fontSize: 20,color: Colors.white)
            );
          }
      }
    else
      {
        return Text(
            "Remaining Score : 0",style: TextStyle(fontSize: 20,color: Colors.white)
        );
      }
  }

}