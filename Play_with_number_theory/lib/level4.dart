import 'dart:async';

import 'package:android_projects/database.dart';
import 'package:android_projects/level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class level4 extends StatefulWidget
{
  String username4="";
  String score4="";
  String level_gain4="";
  String status4="";
  level4(String name,String sc, String levl, String stat)
  {
    this.username4=name;
    this.score4=sc;
    this.level_gain4=levl;
    this.status4=stat;
  }
  @override
  State<StatefulWidget> createState()=> level_4();

}
class level_4 extends State<level4>
{
  int sec_bits=2700;
  int max_score=1600;
  int max_sec=2700;
  int scoretime=2700;

  int min=45;
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
                          Text("LEVEL 4",style: TextStyle(color: Colors.white,
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
                    child: Text("                        [SCROLLABLE TEXT]\n"
                        "You are given a rectangular matrix of size n×m consisting of integers from  2 to 2⋅10^5.\n"
                        "In one move, you can: \n"
                        "1. choose any element of the matrix and change its value to any integer between 2 and n⋅m, inclusive;\n"
                        "2. take any column and shift it one cell up cyclically."
                        "\n\nA cyclic shift is an operation such that you choose some j (2≤j≤m) and set a1,j:=a2,j, a2,j:=a3,j, …,an,j:=a1,j simultaneously."
                        "\nYou have to find permutation for n=5 m=5 \nsuch as m.n=25 "
                        "\nFor every worng submission, your score is downed to 300",
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
                      int x=0;
                      print(array.length);

                      if(array.length==26)
                      {
                        for(int i=1;i<25;i++)
                        {
                          if(array[i]==i+1)
                          {
                            x++;
                          }
                        }
                        print(x);
                        if(x==24 )
                        {
                          int level_gaintoint = int.parse(widget.level_gain4);
                          if (level_gaintoint < 4)
                          {
                            int score_toint = int.parse(widget.score4);
                            String score = (score_toint + max_score).toString();
                            if ((score_toint + max_score) < score_toint) {
                              Dbprovider.updateinfo(
                                  widget.username4, "4", score, "-1");
                              timer?.cancel();
                              showaccepted(context);
                            }
                            else {
                              Dbprovider.updateinfo(
                                  widget.username4, "4", score, "0");
                              timer?.cancel();
                              showaccepted(context);
                            }
                          }
                          else {
                            timer?.cancel();
                            showaccepted(context);
                          }
                        }
                        else
                        {
                          showrejected(context);
                          max_score=max_score-300;
                        }

                      }
                      else{
                        showrejected(context);
                        max_score=max_score-300;
                      }
                    }, child: Text("Submit"),style: _buttonStyle,),

                    ElevatedButton(onPressed: (){
                      timer?.cancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username4,
                          widget.score4,widget.level_gain4,"-1")));

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
    int level_gaintoint=int.parse(widget.level_gain4);
    if(level_gaintoint<4)
    {
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
          content: Text("Achieved Score: $max_score & You Successfully Unlocked Level 5"),
          actions: [
            ElevatedButton(onPressed: (){
              int score4_toint=int.parse(widget.score4);
              int newscore_toint=score4_toint+max_score;
              String newscore=newscore_toint.toString();
              if(newscore_toint<score4_toint)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username4, newscore,"4","-1")));
              }
              else
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username4, newscore,"4","0")));
              }
            }, child: Text("Proceed"))
          ],
        );
      }
      );
    }
    else
    {
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: Text("Accepted",style: TextStyle(color: Colors.greenAccent)),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username4,
                  widget.score4,widget.level_gain4,widget.status4)));
            }, child: Text("Proceed"))
          ],
        );
      });
    }
  }
  showrejected(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain4);
    if(level_gaintoint<4)
    {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
          content: Text("Your maximum score is decremented by 300"),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username4,
                widget.score4,widget.level_gain4,widget.status4)));
          }, child:Text("EXIT"))
        ],
      );
    }
    );
  }

  Widget setscore()
  {
    int level_gaintoint=int.parse(widget.level_gain4);
    if(level_gaintoint<4)
    {
      if(sec_bits==(scoretime-300))
      {
        scoretime=scoretime-300;
        max_score=max_score-450;
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