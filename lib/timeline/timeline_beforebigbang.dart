import 'package:tamadun/screens/beforetheexistence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_beforebigbang.dart';

class FetchTimelineBefore extends StatefulWidget {
  const FetchTimelineBefore({Key? key}) : super(key: key);

  @override
  State<FetchTimelineBefore> createState() => _FetchTimelineBeforeState();
}

class _FetchTimelineBeforeState extends State<FetchTimelineBefore> {
  final List _beforeExist = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchTimelineBefore() async {
    QuerySnapshot qn_before =
    await _firestoreInstance.collection("before-the-existence").get();
    setState(() {
      for (int i = 0; i < qn_before.docs.length; i++) {
        _beforeExist.add({
          "info-title": qn_before.docs[i]["info-title"],
          "info-sub": qn_before.docs[i]["info-sub"],
          "info-desc": qn_before.docs[i]["info-desc"],
          "info-img": qn_before.docs[i]["info-img"],
          "info-surah": qn_before.docs[i]["info-surah"],
          "info-translation": qn_before.docs[i]["info-translation"],
          "info-surah_name": qn_before.docs[i]["info-surah_name"],
          "trans-text": qn_before.docs[i]["trans-text"],
          "surah-id": qn_before.docs[i]["surah-id"],
          "video-id": qn_before.docs[i]["video-id"],
        });
      }
    });
    return qn_before.docs;
  }

  @override
  void initState() {
    fetchTimelineBefore();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Before the Existence of Universe",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => universe()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _beforeExist.length,
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
                                    InfoBeforeExistence(_beforeExist[index]))),
                        child: Container(
                          height: 200,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _beforeExist[index]["info-img"][0],
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
                          "${_beforeExist[index]["info-title"]}",
                          textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              startChild: Center(
                child: Text(
                  "${_beforeExist[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
