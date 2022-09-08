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

  fetchTimelineEmpire() async {
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

  bool _isloading = false;
  @override
  void initState() {
    _isloading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isloading = false;
      });
    });
    fetchTimelineEmpire();
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
            "The Islamic Empire",
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
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => empierofislam()));
            // },
            onPressed: () {
              /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => empierofislam()));*/
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => empierofislam()));
              });
            },
          ),
        ),
        body: _isloading
            ? Center(
          child: CircularProgressIndicator(
            color: Color(
              hexColor('#25346a'),
            ),
          ),
        )
            : screenWidth < 576
            ? ListView.builder(
            itemCount: _empire.length,
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
                                  builder: (_) =>
                                      InfoEmpire(_empire[index]))),
                          child: Container(
                            height: 300,
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
                          child: Text("${_empire[index]["info-title"]}",
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
                    "${_empire[index]["info-sub"]}",
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
            : _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : screenWidth < 2800
            ? ListView.builder(
            itemCount: _empire.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 20, color: Colors.black
                ),
                beforeLineStyle: const LineStyle(
                  thickness: 1,
                  color: Colors.black,
                ),
                lineXY: 0.2,
                endChild: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      10, 200, 10, 200),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InfoEmpire(
                                      _empire[index]))),
                          child: Container(
                            height: 500,
                            width: 520,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _empire[index]["info-img"][0],
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
                            color: Color(
                              hexColor('#BFddbe90'),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${_empire[index]["info-title"]}",
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
                    "${_empire[index]["info-sub"]}",
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
