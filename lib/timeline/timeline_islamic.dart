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
          "info-surah": qn_homosapiens.docs[i]["info-surah"],
          "info-translation": qn_homosapiens.docs[i]["info-translation"],
          "info-surah_name": qn_homosapiens.docs[i]["info-surah_name"],
          "trans-text": qn_homosapiens.docs[i]["trans-text"],
          "video-id": qn_homosapiens.docs[i]["video-id"],
          "desc-id": qn_homosapiens.docs[i]["desc-id"],
        });
      }
    });
    return qn_homosapiens.docs;
  }

  bool _isloading = false;
  @override
  void initState() {
    _isloading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isloading = false;
      });
    });
    timelineHomosapiens();
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
            "The First Man on Earth",
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
              Icons.arrow_back,
              color: Colors.black,
            ),
            // onPressed: () {
            //   Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (context) => homosapiens()));
            // },
            onPressed: () {
              /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => empierofislam()));*/
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homosapiens()));
              });
            },
          ),
        ),

        //mobile
        body: _isloading
            ? Center(
          child: CircularProgressIndicator(
            color: Color(hexColor('#25346a'),
            ),
          ),
        )

        //tablet
            : _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(hexColor('#25346a'),
              ),
            )
        ):
        screenWidth < 576
            ? ListView.builder(
            itemCount: _homosapiens.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 13, color: Colors.black),
                beforeLineStyle: const LineStyle(
                  thickness: 1,
                  color: Colors.black,
                ),
                lineXY: 0.2,
                endChild: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 100, 10, 100),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InfoHomosapiens(
                                      _homosapiens[index]))),
                          child: Container(
                            height: 300,
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
                              "${_homosapiens[index]["info-title"]}",
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
                    "${_homosapiens[index]["info-sub"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'PoppinsLight',
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            })

        //tablet
            : screenWidth < 2800
            ? ListView.builder(
            itemCount: _homosapiens.length,
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
                  padding:
                  const EdgeInsets.fromLTRB(10, 200, 10, 200),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InfoHomosapiens(
                                      _homosapiens[index]))),
                          child: Container(
                            height: 500,
                            width: 520,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _homosapiens[index]["info-img"]
                                  [0],
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
                            borderRadius: BorderRadius.circular(4),
                            color: Color(
                              hexColor('#BFddbe90'),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${_homosapiens[index]["info-title"]}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18.0,
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
                    "${_homosapiens[index]["info-sub"]}",
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
            : null);
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