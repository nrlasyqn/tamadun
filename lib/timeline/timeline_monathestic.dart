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
          "info-desc": qn_monathestic.docs[i]["info-desc"],
          "info-surah": qn_monathestic.docs[i]["info-surah"],
          "info-translation": qn_monathestic.docs[i]["info-translation"],
          "info-surah_name": qn_monathestic.docs[i]["info-surah_name"],
          "trans-text": qn_monathestic.docs[i]["trans-text"],
          "video-id": qn_monathestic.docs[i]["video-id"],
          "desc-id": qn_monathestic.docs[i]["desc-id"],
        });
      }
    });
    return qn_monathestic.docs;
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
            "The Monotheistic Empire",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
                  .push(MaterialPageRoute(builder: (context) => monotheistic_empire()));
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
            : screenWidth < 576
            ? ListView.builder(
            itemCount: _monathestic.length,
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
                  padding: const EdgeInsets.fromLTRB(10, 200, 10, 200),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InfoMonathestic(
                                      _monathestic[index]))),
                          child: Container(
                            height: 300,
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
                          ),),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${_monathestic[index]["info-title"]}",
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
                    "${_monathestic[index]["info-sub"]}",
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
            : screenWidth < 992
            ? ListView.builder(
            itemCount: _monathestic.length,
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
                                  builder: (_) => InfoMonathestic(
                                      _monathestic[index]))),
                          child: Container(
                            height: 400,
                            width: 420,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  _monathestic[index]["info-img"]
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
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(
                            hexColor('#BFddbe90'),
                          ),),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              "${_monathestic[index]["info-title"]}",
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
                    "${_monathestic[index]["info-sub"]}",
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