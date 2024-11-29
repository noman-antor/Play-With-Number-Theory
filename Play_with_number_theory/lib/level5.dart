import 'dart:async';

import 'package:android_projects/database.dart';
import 'package:android_projects/level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class level5 extends StatefulWidget
{
  String username5="";
  String score5="";
  String level_gain5="";
  String status5="";
  level5(String name,String sc, String levl, String stat)
  {
    this.username5=name;
    this.score5=sc;
    this.level_gain5=levl;
    this.status5=stat;
  }
  @override
  State<StatefulWidget> createState()=> level_5();

}
class level_5 extends State<level5>
{
  int sec_bits=2700;
  int max_score=2000;
  int max_sec=2700;
  int scoretime=2700;

  int min=45;
  int sec=00;
  Timer? timer;

  final TextEditingController take_answer=TextEditingController();
  final TextEditingController take_answer2=TextEditingController();
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
    int min(int x,int y)
    {
      if(x>y)
      {
        return y;
      }
      else
      {
        return x;
      }
    }
    int max(int x,int y)
    {
      if(x>y)
      {
        return x;
      }
      else
      {
        return y;
      }
    }
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
                          Text("LEVEL 5",style: TextStyle(color: Colors.white,
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
                        "\nA permutation of length n is an array containing each integer from 1 to n-1 exactly once.There will be two arrays one is p and another is q .Between these two max(pi,qi)!=min(pi,qi) and pi+qi=n."
                        "\n\nInput\nThe first line contains integer n  — the number of elements in permutation p."
                        "\n\nOutput\nThe one line should contain n different integers pi (1≤pi≤n) — the elements of the permutation p and second line should contain n different integers qi (1≤qi≤n) — the elements of the permutation q. If there are several solutions print any of them."
                        "\n\nYour task is to obey the following statement.\n"
                        "You have to find permutation for n=11\n"
                        "For every worng submission,your score is decremented by 100",
                        style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Times New Roman"),textAlign: TextAlign.justify),
                  )
              ),
              SizedBox(height: 10),
              TextField(
                controller: take_answer,
                decoration: InputDecoration(

                    border: OutlineInputBorder(),
                    hintText: "Answer 1",
                    suffixIcon: IconButton(icon: Icon(Icons.cancel),onPressed: (){
                      take_answer.clear();
                    },)
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: take_answer2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Answer 2 if needed",
                    suffixIcon: IconButton(icon: Icon(Icons.cancel),onPressed: (){
                      take_answer2.clear();
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
                      String answer2=take_answer2.text;
                      int n=11;
                      if(answer.isEmpty || answer2.isEmpty)
                        {
                          showrejected(context);
                          max_score=max_score-400;

                        }
                      else
                        {
                          print("Else reading");
                        List <int> array = [100];
                        List <int> arr = [100];
                        int y = 0;
                        for (int i = 0; i < answer.length; i++) {
                          if (answer[i] != " ") {
                            y = y * 10 + int.parse(answer[i]);
                            if (i == (answer.length - 1)) {
                              array.add(y);
                            }
                          }
                          else {
                            array.add(y);
                            y = 0;
                          }
                        }
                        y = 0;
                        for (int i = 0; i < answer2.length; i++)
                        {
                          if (answer2[i] != " ") {
                            y = y * 10 + int.parse(answer2[i]);
                            if (i == (answer2.length - 1)) {
                              arr.add(y);
                            }
                          }
                          else {
                            arr.add(y);
                            y = 0;
                          }
                        }
                        print(array.length);
                        print(arr.length);
                        if(array.length<11 || array.length>11 || arr.length<11 || arr.length>11)
                          {
                            showrejected(context);
                            max_score=max_score-400;
                          }
                        else
                          {
                            int x = 0;
                            for (int i = 1; i < n; i++)
                            {
                            if ((array[i] + arr[i] == n))
                            {
                            x++;
                            }
                            }
                            y = 0;
                            int d = 0;
                            int a = 0;
                            int b = 0;
                            int c = 0;
                            for (int i = 1; i < n; i++)
                            {
                            y = array[i];
                            d = arr[i];
                            a = max(y, d);
                            b = min(y, d);
                            if (a != b)
                            {

                            }
                            else
                            {
                            c = 1;
                            break;
                            }
                            }
                            if (x == n - 1 && c == 0)
                            {
                            int level_gaintoint = int.parse(widget.level_gain5);
                            if (level_gaintoint < 5) {
                            int score_toint = int.parse(widget.score5);
                            String score = (score_toint + max_score).toString();
                            if ((score_toint + max_score) < score_toint) {
                            Dbprovider.updateinfo(
                            widget.username5, "5", score, "-1");
                            timer?.cancel();
                            showaccepted(context);
                            }
                            else {
                            Dbprovider.updateinfo(
                            widget.username5, "5", score, "0");
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
                            max_score = max_score - 400;
                            }
                            }
                          }



                    }, child: Text("Submit"),style: _buttonStyle,),

                    ElevatedButton(onPressed: (){
                      timer?.cancel();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username5,
                          widget.score5,widget.level_gain5,"-1")));

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

  Widget buildtimer()=>SizedBox
    (
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
    int level_gaintoint=int.parse(widget.level_gain5);
    if(level_gaintoint<5)
    {
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: Text("Congratulations",style: TextStyle(color: Colors.greenAccent)),
          content: Text("Achieved Score: $max_score & You have successfully finished all levels"),
          actions: [
            ElevatedButton(onPressed: (){
              int score4_toint=int.parse(widget.score5);
              int newscore_toint=score4_toint+max_score;
              String newscore=newscore_toint.toString();
              if(newscore_toint<score4_toint)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username5, newscore,"5","-1")));
              }
              else
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username5, newscore,"5","0")));
              }
            }, child: Text("Take Rest"))
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>level(widget.username5,
                  widget.score5,widget.level_gain5,widget.status5)));
            }, child: Text("Take Rest"))
          ],
        );
      });
    }
  }
  showrejected(BuildContext context)
  {
    int level_gaintoint=int.parse(widget.level_gain5);
    if(level_gaintoint<5)
    {
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Wrong Answer",style: TextStyle(color: Colors.red)),
          content: Text("Your maximum score is decremented by 400"),
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
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>level(widget.username5,
                widget.score5,widget.level_gain5,widget.status5)));
          }, child:Text("EXIT"))
        ],
      );
    });
  }

  Widget setscore()
  {
    int level_gaintoint=int.parse(widget.level_gain5);
    if(level_gaintoint<5)
    {
      if(sec_bits==(scoretime-300))
      {
        scoretime=scoretime-300;
        max_score=max_score-650;
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