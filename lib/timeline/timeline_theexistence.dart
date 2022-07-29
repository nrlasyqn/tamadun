import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/the_existence.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info-theexistence.dart';

class TimelineExistence extends StatefulWidget {
  const TimelineExistence({Key? key}) : super(key: key);

  @override
  State<TimelineExistence> createState() => _TimelineExistenceState();
}

class _TimelineExistenceState extends State<TimelineExistence> {

  final List _theExist = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchExistence() async {
    QuerySnapshot qn_exist =
    await _firestoreInstance.collection("the-existence-of-universe").get();
    setState(() {
      for (int i = 0; i < qn_exist.docs.length; i++) {
        _theExist.add({
          "info-title": qn_exist.docs[i]["info-title"],
          "info-sub": qn_exist.docs[i]["info-sub"],
          "info-desc": qn_exist.docs[i]["info-desc"],
          "info-img": qn_exist.docs[i]["info-img"],
          "info-surah": qn_exist.docs[i]["info-surah"],
          "info-translation": qn_exist.docs[i]["info-translation"],
          "info-surah_name": qn_exist.docs[i]["info-surah_name"],
          "info-tafsir-surah-0": qn_exist.docs[i]["info-tafsir-surah-0"],
          "info-tafsir-surah-1": qn_exist.docs[i]["info-tafsir-surah-1"],
          "info-tafsir-surah-2": qn_exist.docs[i]["info-tafsir-surah-2"],
          "tafsir-text": qn_exist.docs[i]["tafsir-text"],
          "surah-id": qn_exist.docs[i]["surah-id"],
          "video-id": qn_exist.docs[i]["video-id"],
          "tafseer-id": qn_exist.docs[i]["tafseer-id"],
        });
      }
    });
    return qn_exist.docs;
  }

  @override
  void initState() {
    fetchExistence();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "The Starting Point of Universe Creation",
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
                .push(MaterialPageRoute(builder: (context) => the_existence()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _theExist.length,
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
                                      InfoTheExistence(_theExist[index]))),
                          child: Container(
                            height: 200,
                            width: 420,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _theExist[index]["info-img"][0],
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
                            "${_theExist[index]["info-title"]}",
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
                  "${_theExist[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
