import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_page/info_monathestic.dart';
import 'package:tamadun/screens/monotheistic_empire.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineMonathestic extends StatefulWidget {
  const TimelineMonathestic({Key? key}) : super(key: key);

  @override
  State<TimelineMonathestic> createState() => _TimelineMonathesticState();
}

class _TimelineMonathesticState extends State<TimelineMonathestic> {
  final List _monathestic = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  timelineHomosapiens() async {
    QuerySnapshot qn_monathestic =
    await _firestoreInstance.collection("monathestic-empire").get();
    setState(() {
      for (int i = 0; i < qn_monathestic.docs.length; i++) {
        _monathestic.add({
          "info-title": qn_monathestic.docs[i]["info-title"],
          "info-sub": qn_monathestic.docs[i]["info-sub"],
          "info-img": qn_monathestic.docs[i]["info-img"],
          "video-id": qn_monathestic.docs[i]["video-id"],
          "desc-id": qn_monathestic.docs[i]["desc-id"],
        });
      }
    });
    return qn_monathestic.docs;
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
          "The Monotheistic Empire",
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
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => monotheistic_empire()));*/
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => monotheistic_empire()));
            });
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _monathestic.length,
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
                                    InfoMonathestic(_monathestic[index]))),
                        child: Container(
                          height: 200,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _monathestic[index]["info-img"][0],
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
                          "${_monathestic[index]["info-title"]}",
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
                  "${_monathestic[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
