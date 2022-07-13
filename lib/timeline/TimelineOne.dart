import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineOne extends StatefulWidget {
  const TimelineOne({Key? key}) : super(key: key);

  @override
  State<TimelineOne> createState() => _TimelineOneState();
}

class _TimelineOneState extends State<TimelineOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'The Existence of Universe',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed:(){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
          ),
        ),

        body: ListView.builder(
            itemBuilder: (context, i) {
              return Column(
                  children: [
                    SizedBox(
                      width: 1000,
                      height: 200,
                      child: TimelineTile(
                        afterLineStyle: LineStyle(
                            color: Colors.black, thickness: 1),
                        beforeLineStyle: LineStyle(
                            color: Colors.black, thickness: 1),
                        startChild: Text('$i', textAlign: TextAlign.center), //todo: note=> set i to counting year later
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        indicatorStyle: const IndicatorStyle(
                          width: 10,
                          color: Colors.black,

                          //padding: EdgeInsets.all(8) //todo: notes=>padding between line and indicator
                          // indicatorXY: 0.2, //todo: notes=> to set space between the indicator

                        ),
                      ),
                    ),

                    //todo: horizontal line
                    SizedBox(
                      width: 1000,
                      height: 1,
                      child: TimelineTile(
                        //todo: counting distance between year/decade
                        //startChild : Text('$i', textAlign: TextAlign.center), //i => counting year
                        alignment: TimelineAlign.manual,
                        lineXY: 0.08,
                        indicatorStyle: IndicatorStyle(
                            color: Colors.black,
                            indicator: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            )
                        ),
                      ),
                    ),
                  ]
              );
            }
        ));
  }
}
