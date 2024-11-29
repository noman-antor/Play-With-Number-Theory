import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class showrank extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()=>_showrank();

}
class _showrank extends State<showrank>
{
  List<String> db_user=[];
  List<int> db_score=[];

  List<String> remake_user=[];
  List<int> remake_score=[];

  int count=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    remake_database();
  }

  void remake_database() async
  {
    int z=0;
    var result=await Dbprovider.readall();
    if(result!=null && result.length>0)
      {
        for(int i=0;i<result.length;i++)
          {
            String name=result[i].username;
            int score=int.parse(result[i].score);
            setState(() {
              db_user.add(name);
              db_score.add(score);
            });
          }
        while(z<result.length)
        {
          int max=db_score[0];
          int store =0;
          for(int i=0;i<result.length;i++)
          {
            if(max<db_score[i])
            {
              setState(() {
                max=db_score[i];
                store=i;
              });
            }
          }
          setState(() {
            remake_score.add(max);
            db_score[store]=-1;
            remake_user.add(db_user[store]);
            z++;
          });
        }
      }
  }
  String setRank(int x)
  {
    if(x==0)
      {
        count++;
        String y=count.toString();
        return "Rank $y";
      }
    else
      {
        if(remake_score[x]!=remake_score[x-1])
        {
          count++;
          String y=count.toString();
          return "Rank $y";
        }
        else
        {
          String y=count.toString();
          return "Rank $y";
        }
      }
  }

  Color select_color(int x) {

    if (x < 500) {
      return Colors.grey;
    }
    else if (x >= 500 && x < 1200) {
      return Colors.green;
    }
    else if (x >= 1200 && x < 1600) {
      return Colors.cyan;
    }
    else if (x >= 1600 && x < 2000) {
      return Colors.blue;
    }
    else if (x >= 2000 && x < 2500) {
      return Colors.purple;
    }
    else {
      return Colors.red;
    }
  }

  String select_pos(int score_toint) {

    if (score_toint < 500) {
      return "(Noob)";
    }
    else if (score_toint >= 500 && score_toint < 1200) {
      return "(Enthusiast)";
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.black,
      title: Text("Player's Rank",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "Times New Roman"))),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: remake_user.length,
            itemBuilder: (BuildContext context, int index){
              return Container(decoration: BoxDecoration(border: Border(bottom: BorderSide(color: select_color(remake_score[index])))),
                  child: ListTile(
                    leading: Text(setRank(index),
                        style: TextStyle(color:select_color(remake_score[index]),
                            fontSize: 18,fontFamily: "Times New Roman")),
                    title: Text(remake_user[index],
                        style: TextStyle(color:select_color(remake_score[index]),
                            fontSize: 18,fontFamily: "Times New Roman")),
                    trailing: Text(remake_score[index].toString(),
                        style: TextStyle(color:select_color(remake_score[index]),
                            fontSize: 18,fontFamily: "Times New Roman")),
                    subtitle: Text(select_pos(remake_score[index]),
                      style: TextStyle(color: select_color(remake_score[index]),fontFamily: "Times New Roman"),),
                  )

              );
                
          }),
        )

      ),
    );
  }

}