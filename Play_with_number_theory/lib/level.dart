import 'package:android_projects/level1.dart';
import 'package:android_projects/showrank.dart';
import 'package:android_projects/sp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'database.dart';
import 'datamodel.dart';

import 'level2.dart';
import 'level3.dart';
import 'level4.dart';
import 'level5.dart';
import 'login.dart';

class level extends StatelessWidget {
  String name = "";
  String score = "";
  String levelpass = "";
  String status = "";

  level(String name, String score, String level, String status) {
    this.name = name;
    this.score = score;
    this.levelpass = level;
    this.status = status;
  }

  @override
  Widget build(BuildContext context) {

    //converting level pass variable to int to increment levels after unlocking a level
    var level_gain = int.parse(levelpass);

    String select_rank() {
      int score_toint = int.parse(score);
      if (score_toint < 500) {
        return "(Noob)";
      }
      else if (score_toint >= 500 && score_toint < 1200) {
        return "(Enthuisast)";
      }
      else if (score_toint >= 1200 && score_toint < 1600) {
        return "(Advanced)";
      }
      else if (score_toint >= 1600 && score_toint < 2000) {
        return "(Brilliant)";
      }
      else if (score_toint >= 2000 && score_toint < 2500) {
        return "(Legend)";
      }
      else {
        return "(Master of Number Theory)";
      }
    }
    Color select_color() {
      int score_toint = int.parse(score);
      if (score_toint < 500) {
        return Colors.grey;
      }
      else if (score_toint >= 500 && score_toint < 1200) {
        return Colors.green;
      }
      else if (score_toint >= 1200 && score_toint < 1600) {
        return Colors.cyan;
      }
      else if (score_toint >= 1600 && score_toint < 2000) {
        return Colors.blue;
      }
      else if (score_toint >= 2000 && score_toint < 2500) {
        return Colors.purple;
      }
      else {
        return Colors.red;
      }
    }
    String set_image()
    {
      int score_toint = int.parse(score);
      if (status == "-1") {
        return "assets/images/minus.png";
      }
      else {
        if (score_toint < 500) {
          return "assets/images/noob.png";
        }
        else if (score_toint >= 500 && score_toint < 1200) {
          return "assets/images/enthuisastt.png";
        }
        else if (score_toint >= 1200 && score_toint < 1600) {
          return "assets/images/advanced.png";
        }
        else if (score_toint >= 1600 && score_toint < 2000) {
          return "assets/images/brilliant.png";
        }
        else if (score_toint >= 2000 && score_toint < 2500) {
          return "assets/images/legend.png";
        }
        else {
          return "assets/images/master.png";
        }
      }
    }
    //checking if the level is locked or not
    Text level_situation(int level_no) {
      if (level_gain >= (level_no - 1) && level_gain <= 5) {
        return Text("LEVEL $level_no", style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "Times New Roman"));
      }
      else {
        return Text("LEVEL LOCKED X", style: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "Times New Roman"));
      }
    }
    //set the subtitle of level list
    Text set_subtitle(int level_no, int max_score) {
      if (level_gain >= (level_no - 1) && level_gain <= 5) {
        return Text("Maximum Score: $max_score", style: TextStyle(
            color: Colors.blueGrey, fontSize: 15, fontFamily: "Times New Roman"));
      }
      else
        {
        return Text("Maximum Score: $max_score", style: TextStyle(
            color: Colors.grey, fontSize: 15, fontFamily: "Times New Roman"));
      }
    }
    //set the icon for list based on the locked level
    Icon set_level_icon(int level_no) {
      if (level_gain >= (level_no - 1) && level_gain <= 5) {
        return Icon(Icons.lock_open_rounded, color: Colors.black, size: 30);
      }
      else {
        return Icon(Icons.lock, color: Colors.grey, size: 30);
      }
    }
    //set the trailing of level list definition
    Text set_trailing(int level_no,String difficulty)
    {
      if (level_gain >= (level_no - 1) && level_gain <= 5) {
        return Text(difficulty, style: TextStyle(
            color: Colors.blueGrey, fontSize: 16, fontFamily: "Times New Roman"));
      }
      else {
        return Text(difficulty, style: TextStyle(
            color: Colors.grey, fontSize: 16, fontFamily: "Times New Roman"));
      }
    }

    void showmsg() {
      final snackBar = SnackBar(content: Text("Please complete the lower level",
          style: TextStyle(color: Colors.white, fontFamily: "Times New Roman")),
        backgroundColor: Colors.black,
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Scaffold(
        body: Container(
          
            padding: EdgeInsets.all(3),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Player Identity",style: TextStyle(color: select_color(),fontSize: 30,
                              fontWeight: FontWeight.bold,fontFamily: "Times New Roman")),
                          SizedBox(width: 80),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                            }, icon: Icon(Icons.logout,color: select_color(),size: 35)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      width: 210,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(set_image()),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                    SizedBox(height: 10),

                    Text("Hello $name", style: TextStyle(color: select_color(),
                        fontFamily: "Times New Roman",
                        fontSize: 35)),
                    SizedBox(height: 2),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(select_rank(), style: TextStyle(
                              color: select_color(),
                              fontFamily: "Times New Roman",
                              fontSize: 25)),
                          SizedBox(height: 5),
                          Text("Achieved Score : $score", style: TextStyle(
                              color: select_color(),
                              fontFamily: "Times New Roman",
                              fontSize: 20)),
                          Text("Level Finished: $levelpass", style: TextStyle(
                              color: select_color(),
                              fontFamily: "Times New Roman",
                              fontSize: 20)),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Text("See Your Ranks",style: TextStyle(fontSize: 20,
                            color: select_color(),fontFamily: "Times New Roman",decoration: TextDecoration.underline),),
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> showrank()));
                            } ,
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child:ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [

                          //Level 1 list creation
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                            child: ListTile(
                              leading: set_level_icon(1),
                              trailing: set_trailing(1, "Easy"),
                              title: level_situation(1),
                              subtitle: set_subtitle(1, 500),
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>level1(name,score,levelpass,status)));
                              },
                            ),
                          ),

                          //Level 2 list creation
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                            child: ListTile(
                              leading: set_level_icon(2),
                              trailing: set_trailing(2, "Medium"),
                              title: level_situation(2),
                              subtitle: set_subtitle(2, 800),
                              onTap: ()
                              {
                                if(level_gain>=1 && level_gain<=5)
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>level2(name,score,levelpass,status)));
                                  }
                                else
                                  {
                                    showmsg();
                                  }
                              },
                            ) ,
                          ),

                          //Level 3 list creation
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                            child: ListTile(
                              leading: set_level_icon(3),
                              trailing: set_trailing(3, "Hard"),
                              title: level_situation(3),
                              subtitle: set_subtitle(3, 1200),
                              onTap: ()
                              {
                                if(level_gain>=2 && level_gain<=5)
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>level3(name,score,levelpass,status)));
                                }
                                else
                                {
                                  showmsg();
                                }
                              },
                            ) ,
                          ),

                          //Level 4 list creation
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                            child: ListTile(
                              leading: set_level_icon(4),
                              trailing: set_trailing(4, "Hard"),
                              title: level_situation(4),
                              subtitle: set_subtitle(4, 1600),
                              onTap: ()
                              {
                                if(level_gain>=3 && level_gain<=5)
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>level4(name,score,levelpass,status)));
                                }
                                else
                                {
                                  showmsg();
                                }
                              },
                            ) ,
                          ),

                          //Level 5 list creation
                          Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                            child: ListTile(
                              leading: set_level_icon(5),
                              trailing: set_trailing(5, "Very Hard"),
                              title: level_situation(5),
                              subtitle: set_subtitle(5, 2000),
                              onTap: ()
                              {
                                if(level_gain>=4 && level_gain<=5)
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>level5(name,score,levelpass,status)));
                                }
                                else
                                {
                                  showmsg();
                                }
                              },
                            ) ,
                          ),
                        ],
                      ),
                    ),
                  ]
              ),
            )
        )
    );
  }
}
