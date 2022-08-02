import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamadun/screens/beforetheexistence.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_beforebigbang.dart';
import '../screens/snackbar.dart';

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
                        onTap: () {
                          final userRole = FirebaseFirestore.instance.collection("Users");
                          final currUser = FirebaseAuth.instance.currentUser!.email;
                          final before = FirebaseFirestore.instance.collection('before-the-existence');
                          userRole.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              //todo: Before The Creation of Universe
                              before.get().then((QuerySnapshot snap) {
                                snap.docs.forEach((DocumentSnapshot docs) {
                                  setState(() {
                                    //doc from before the existence
                                    //data = tamadun-info
                                    if (doc['email'] == currUser) {
                                      //todo : Standard Role
                                      if (doc['role'] == 'standard') {
                                        if (_beforeExist[index]['info-title'] == "The Creation of Qalam") {
                                          if (docs['info-title'] == "The Creation of Qalam") {
                                            Future.delayed(Duration.zero, () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        InfoBeforeExistence(_beforeExist[index])));
                                          });}
                                        }

                                        //the creation of water
                                        if (_beforeExist[index]['info-title'] == "The Creation of Water") {
                                          if (docs['info-title'] == "The Creation of Water") {
                                            showAskUserBar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                        }

                                        //the creation of arash
                                        if (_beforeExist[index]['info-title'] == "The Creation of Arash") {
                                          if (docs['info-title'] == "The Creation of Arash") {
                                            showAskUserBar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                        }
                                      }
                                      //todo: Premium Role
                                      if (doc['role'] == 'premium') {
                                        if (_beforeExist[index]['info-title'] == "The Creation of Qalam") {
                                          if (docs['info-title'] == "The Creation of Qalam") {
                                            Future.delayed(Duration.zero, () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        InfoBeforeExistence(_beforeExist[index])));
                                          });}
                                        }
                                        if (_beforeExist[index]['info-title'] == "The Creation of Water") {
                                          if (docs['info-title'] == "The Creation of Water") {
                                            Future.delayed(Duration.zero, () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        InfoBeforeExistence(_beforeExist[index])));
                                          });}
                                        }
                                        if (_beforeExist[index]['info-title'] == "The Creation of Arash") {
                                          if (docs['info-title'] == "The Creation of Arash") {
                                            Future.delayed(Duration.zero, () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        InfoBeforeExistence(_beforeExist[index])));
                                          });}
                                        }
                                      }
                                    }
                                  });
                                });
                              });
                            }
                            );
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) =>
                          //             InfoBeforeExistence(_beforeExist[index])));
                        },
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
