import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/button.dart';
import 'package:tamadun/screens/empierofislam.dart';
import 'package:tamadun/screens/homosapiens.dart';
import 'package:tamadun/screens/the_ummah.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../info_page/info_islamic.dart';

class TimelineUmmah extends StatefulWidget {
  const TimelineUmmah({Key? key}) : super(key: key);

  @override
  State<TimelineUmmah> createState() => _TimelineUmmahState();
}

class _TimelineUmmahState extends State<TimelineUmmah> {
  final List _ummah = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  timelineHomosapiens() async {
    QuerySnapshot qn_ummah = await _firestoreInstance.collection("ummah").get();
    setState(() {
      for (int i = 0; i < qn_ummah.docs.length; i++) {
        _ummah.add({
          "info-title": qn_ummah.docs[i]["info-title"],
          "info-img": qn_ummah.docs[i]["info-img"],
          "info-sub": qn_ummah.docs[i]["info-sub"],
        });
      }
    });
    return qn_ummah.docs;
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
          title: const Text(
            "The Ummah",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "MontserratBold",
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ummah()));
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
            itemCount: _ummah.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 13, color: Colors.black),
                beforeLineStyle:
                const LineStyle(thickness: 1, color: Colors.black),
                lineXY: 0.2,
                endChild: SizedBox(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 300, 10, 300),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (_) => j())),
                            child: Container(
                              height: 300,
                              width: 420,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _ummah[index]["info-img"][0],
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
                            child:
                            Text("${_ummah[index]["info-title"]}",
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
                ),
                startChild: Center(
                  child: Text(
                    "${_ummah[index]["info-sub"]}",
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
            : _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : screenWidth < 992
            ? ListView.builder(
            itemCount: _ummah.length,
            itemBuilder: (_, index) {
              return TimelineTile(
                alignment: TimelineAlign.manual,
                indicatorStyle: const IndicatorStyle(
                    width: 20, color: Colors.black),
                beforeLineStyle: const LineStyle(
                  thickness: 1,
                  color: Colors.black,
                ),
                lineXY: 0.2,
                endChild: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        10, 400, 10, 400),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => j())),
                            child: Container(
                              height: 400,
                              width: 420,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _ummah[index]["info-img"][0],
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
                          width: 401,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(4),
                              color: Color(
                                hexColor('#BFddbe90'),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                                "${_ummah[index]["info-title"]}",
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
                ),
                startChild: Center(
                  child: Text(
                    "${_ummah[index]["info-sub"]}",
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
