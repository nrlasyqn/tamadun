import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/button.dart';
import 'package:tamadun/screens/empierofislam.dart';
import 'package:tamadun/screens/homosapiens.dart';
import 'package:tamadun/screens/the_ummah.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_islamic.dart';

class TimelineUmmah extends StatefulWidget {
  const TimelineUmmah({Key? key}) : super(key: key);

  @override
  State<TimelineUmmah> createState() => _TimelineUmmahState();
}

class _TimelineUmmahState extends State<TimelineUmmah> {
  final List _ummah = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  timelineHomosapiens() async {
    QuerySnapshot qn_ummah =
    await _firestoreInstance.collection("ummah").get();
    setState(() {
      for (int i = 0; i < qn_ummah.docs.length; i++) {
        _ummah.add({
          "info-title": qn_ummah.docs[i]["info-title"],
          "info-img": qn_ummah.docs[i]["info-img"],

        });
      }
    });
    return qn_ummah.docs;
  }

  @override
  void initState() {
    timelineHomosapiens();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "The First Man on Earth",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ummah()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _ummah.length,
          itemBuilder: (_, index) {
            return TimelineTile(
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                width: 13,
              ),
              beforeLineStyle: LineStyle(
                thickness: 1,
                color: Colors.black,
              ),
              lineXY: 0.2,
              endChild: SizedBox(
                height: 600,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50,140,40,45.0),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      j())),
                          child: Container(
                            height: 200,
                            width: 420,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _ummah[index]["info-img"][0],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            constraints: const BoxConstraints(minHeight: 120),
                          )),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.purple[200]),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "${_ummah[index]["info-title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              startChild: Center(
                child: Text(
                  "${_ummah[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
