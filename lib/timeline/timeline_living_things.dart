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

  bool _isloading = false;
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
        title: const Text(
          "Living Things Before Creation of Man",
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
                .push(MaterialPageRoute(builder: (context) => living_things()));
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
          itemCount: _livingthings.length,
          itemBuilder: (_, index) {
            return TimelineTile(
              alignment: TimelineAlign.manual,
              indicatorStyle:
              const IndicatorStyle(width: 13, color: Colors.black),
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
                                builder: (_) => InfoLivingThings(
                                    _livingthings[index]))),
                        child: Container(
                          height: 300,
                          width: 320,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _livingthings[index]["info-img"][0],
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
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:Color(  hexColor('#BFddbe90'),),),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "${_livingthings[index]["info-title"]}",
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
                  "${_livingthings[index]["info-sub"]}",
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
      //todo: tablet
          : _isloading
          ? Center(
          child: CircularProgressIndicator(
              color: Color(hexColor('#25346a'),)))
          : screenWidth < 992
          ? ListView.builder(
          itemCount: _livingthings.length,
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
                                builder: (_) =>
                                    InfoLivingThings(
                                        _livingthings[index]))),
                        child: Container(
                          height: 400,
                          width: 420,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                _livingthings[index]["info-img"]
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
                      width: 401,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(
                          hexColor('#BFddbe90'),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            "${_livingthings[index]["info-title"]}",
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
                  "${_livingthings[index]["info-sub"]}",
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
          : null,
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
