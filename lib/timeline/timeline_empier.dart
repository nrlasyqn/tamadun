import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/empierofislam.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_empier.dart';


class TimelineEmpire extends StatefulWidget {
  const TimelineEmpire({Key? key}) : super(key: key);

  @override
  State<TimelineEmpire> createState() => _TimelineEmpireState();
}

class _TimelineEmpireState extends State<TimelineEmpire> {
  final List _empire = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchTimelineEmpire() async{
    QuerySnapshot qn_empire =
    await _firestoreInstance.collection("the-islamic-empire").get();
    setState(() {
      for (int i = 0; i < qn_empire.docs.length; i++) {
        _empire.add({
          "info-title": qn_empire.docs[i]["info-title"],
          "info-sub": qn_empire.docs[i]["info-sub"],
          "desc-id": qn_empire.docs[i]["desc-id"],
          "info-img": qn_empire.docs[i]["info-img"],
          "video-id": qn_empire.docs[i]["video-id"],
        });
      }
    });
    return qn_empire.docs;
  }

  @override
  void initState() {
    fetchTimelineEmpire();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "The Islamic Empire",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => empierofislam()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _empire.length,
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
                                    InfoEmpire(_empire[index]))),
                        child: Container(
                          height: 200,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _empire[index]["info-img"][0],
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
                          "${_empire[index]["info-title"]}",
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
                  "${_empire[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
