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
  bool _isloading = false;
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
    _isloading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isloading = false;
      });
    });
    fetchTimelineBefore();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: const Text(
            "Before the Existence of Universe",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontFamily: "MontserratBold",
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => universe()));
            },
          ),
        ),
        body: _isloading
            ? Center(
          child: CircularProgressIndicator(
            color: Color(hexColor('#25346a'),
            ),
          ),
        )

        //todo:mobileview
            : screenWidth < 576
            ? ListView.builder(
            itemCount: _beforeExist.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 13,
                    color: Colors.black
                ),
                beforeLineStyle: const LineStyle(
                  thickness: 1,
                  color: Colors.black,
                ),
                lineXY: 0.2,
                endChild: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 300, 10, 300),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            final userRole = FirebaseFirestore.instance
                                .collection("Users");
                            final currUser = FirebaseAuth
                                .instance.currentUser!.email;
                            final before = FirebaseFirestore.instance
                                .collection('before-the-existence');
                            userRole
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                //todo: Before The Creation of Universe
                                before.get().then((QuerySnapshot snap) {
                                  snap.docs
                                      .forEach((DocumentSnapshot docs) {
                                    setState(() {
                                      //doc from before the existence
                                      //data = tamadun-info
                                      if (doc['email'] == currUser) {
                                        //todo : Standard Role
                                        if (doc['role'] == 'standard') {
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Qalam") {
                                            if (docs['info-title'] ==
                                                "The Creation of Qalam") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          InfoBeforeExistence(
                                                              _beforeExist[
                                                              index])));
                                            }
                                          }

                                          //the creation of water
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Water") {
                                            if (docs['info-title'] ==
                                                "The Creation of Water") {
                                              showAskUserBar(
                                                  context: context,
                                                  message:
                                                  'Upgrade to Premium Now !!',
                                                  isError: false);
                                            }
                                          }

                                          //the creation of arash
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Arash") {
                                            if (docs['info-title'] ==
                                                "The Creation of Arash") {
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
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Qalam") {
                                            if (docs['info-title'] ==
                                                "The Creation of Qalam") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          InfoBeforeExistence(
                                                              _beforeExist[
                                                              index])));
                                            }
                                          }
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Water") {
                                            if (docs['info-title'] ==
                                                "The Creation of Water") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          InfoBeforeExistence(
                                                              _beforeExist[
                                                              index])));
                                            }
                                          }
                                          if (_beforeExist[index]
                                          ['info-title'] ==
                                              "The Creation of Arash") {
                                            if (docs['info-title'] ==
                                                "The Creation of Arash") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          InfoBeforeExistence(
                                                              _beforeExist[
                                                              index])));
                                            }
                                          }
                                        }
                                      }
                                    });
                                  });
                                });
                              });
                            });
                          },
                          child: Container(
                            height: 300,
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
                            constraints:
                            const BoxConstraints(minHeight: 120),
                          )),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(
                            hexColor('#BFddbe90'),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${_beforeExist[index]["info-title"]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'PoppinsMedium',
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                startChild: Center(
                  child: Text(
                    "${_beforeExist[index]["info-sub"]}",
                    textAlign: TextAlign.center,
                    style: const  TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'PoppinsLight',
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            })
        //tablet
            : _isloading
            ? Center(
          child: CircularProgressIndicator(
            color: Color(hexColor('#25346a'),
            ),
          ),

          //todo:tablet
        ): screenWidth < 2800
            ? ListView.builder(
            itemCount: _beforeExist.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.black
                ),
                beforeLineStyle: const LineStyle(
                  thickness: 1,
                  color: Colors.black,
                ),
                lineXY: 0.2,
                endChild: Padding(
                  padding: EdgeInsets.fromLTRB(10, 400, 10, 400),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            final userRole = FirebaseFirestore
                                .instance
                                .collection("Users");
                            final currUser = FirebaseAuth
                                .instance.currentUser!.email;
                            final before = FirebaseFirestore
                                .instance
                                .collection(
                                'before-the-existence');
                            userRole
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach(
                                      (DocumentSnapshot doc) {
                                    //todo: Before The Creation of Universe
                                    before
                                        .get()
                                        .then((QuerySnapshot snap) {
                                      snap.docs.forEach(
                                              (DocumentSnapshot docs) {
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] ==
                                                  currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] ==
                                                    'standard') {
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Qalam") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Qalam") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist[index])));
                                                    }
                                                  }

                                                  //the creation of water
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Water") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Water") {
                                                      showAskUserBar(
                                                          context:
                                                          context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError:
                                                          false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Arash") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Arash") {
                                                      showAskUserBar(
                                                          context:
                                                          context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError:
                                                          false);
                                                    }
                                                  }
                                                }
                                                //todo: Premium Role
                                                if (doc['role'] ==
                                                    'premium') {
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Qalam") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Qalam") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist[index])));
                                                    }
                                                  }
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Water") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Water") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist[index])));
                                                    }
                                                  }
                                                  if (_beforeExist[
                                                  index][
                                                  'info-title'] ==
                                                      "The Creation of Arash") {
                                                    if (docs[
                                                    'info-title'] ==
                                                        "The Creation of Arash") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist[index])));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                    });
                                  });
                            });
                          },
                          child: Container(
                            height: 500,
                            width: 520,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _beforeExist[index]
                                  ["info-img"][0],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                              BorderRadius.circular(16),
                            ),
                            constraints: const BoxConstraints(
                                minHeight: 120),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(4),
                          color:Color(  hexColor('#BFddbe90'),),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              "${_beforeExist[index]["info-title"]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18.0,
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
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'PoppinsLight',
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            })
            : null
    );
  }
}

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}