import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/empierofislam.dart';
import 'package:tamadun/screens/homosapiens.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_islamic.dart';

class TimelineHomosapiens extends StatefulWidget {
  const TimelineHomosapiens({Key? key}) : super(key: key);

  @override
  State<TimelineHomosapiens> createState() => _TimelineHomosapiensState();
}

class _TimelineHomosapiensState extends State<TimelineHomosapiens> {
  final List _homosapiens = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  timelineHomosapiens() async {
    QuerySnapshot qn_homosapiens =
    await _firestoreInstance.collection("first-man-on-earth").get();
    setState(() {
      for (int i = 0; i < qn_homosapiens.docs.length; i++) {
        _homosapiens.add({
          "info-title": qn_homosapiens.docs[i]["info-title"],
          "info-sub": qn_homosapiens.docs[i]["info-sub"],
          "info-desc": qn_homosapiens.docs[i]["info-desc"],
          "info-img": qn_homosapiens.docs[i]["info-img"],
          "info-video": qn_homosapiens.docs[i]["info-video"],
          "info-surah": qn_homosapiens.docs[i]["info-surah"],
          "info-translation": qn_homosapiens.docs[i]["info-translation"],
          "info-surah_name": qn_homosapiens.docs[i]["info-surah_name"],
        });
      }
    });
    return qn_homosapiens.docs;
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
          "Homo Sapiens",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => homosapiens()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _homosapiens.length,
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
              endChild: Padding(
                padding: EdgeInsets.all(45.0),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    InfoHomosapiens(_homosapiens[index]))),
                        child: Container(
                          height: 200,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _homosapiens[index]["info-img"][0],
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
                          "${_homosapiens[index]["info-title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              startChild: Center(
                child: Text(
                  "${_homosapiens[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
