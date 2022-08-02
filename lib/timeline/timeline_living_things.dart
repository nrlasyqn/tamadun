import 'package:tamadun/info_page/info_living_things.dart';
import 'package:tamadun/screens/beforetheexistence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/living_things.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_beforebigbang.dart';

class TimelineLivingThings extends StatefulWidget {
  const TimelineLivingThings({Key? key}) : super(key: key);

  @override
  State<TimelineLivingThings> createState() => _TimelineLivingThingsState();
}

class _TimelineLivingThingsState extends State<TimelineLivingThings> {
  final List _livingthings = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchTimelineBefore() async {
    QuerySnapshot qn_before =
    await _firestoreInstance.collection("living-things").get();
    setState(() {
      for (int i = 0; i < qn_before.docs.length; i++) {
        _livingthings.add({
          "info-title": qn_before.docs[i]["info-title"],
          "info-sub": qn_before.docs[i]["info-sub"],
          "info-desc": qn_before.docs[i]["info-desc"],
          "info-img": qn_before.docs[i]["info-img"],
          "info-surah": qn_before.docs[i]["info-surah"],
          "info-tafsir": qn_before.docs[i]["info-tafsir"],
          "tafsir-text": qn_before.docs[i]["tafsir-text"],
          "trans-text": qn_before.docs[i]["trans-text"],
          "info-tafsir-name": qn_before.docs[i]["info-tafsir-name"],
          "info-translation": qn_before.docs[i]["info-translation"],
          "info-surah_name": qn_before.docs[i]["info-surah_name"],
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
          "Living Things Before Creation of Man",
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
                .push(MaterialPageRoute(builder: (context) => living_things()));*/
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => living_things()));
            });
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _livingthings.length,
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
                                    InfoLivingThings(_livingthings[index]))),
                        child: Container(
                          height: 200,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _livingthings[index]["info-img"][0],
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
                            "${_livingthings[index]["info-title"]}",
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
                  "${_livingthings[index]["info-sub"]}",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
