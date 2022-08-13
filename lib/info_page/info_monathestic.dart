import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/video.dart';

import '../info_video/info_video_monathestic.dart';

class InfoMonathestic extends StatefulWidget {
  final _monathestic;
  const InfoMonathestic(this._monathestic);

  @override
  State<InfoMonathestic> createState() => _InfoMonathesticState();
}

class _InfoMonathesticState extends State<InfoMonathestic> {
  //todo: add favorite function
  Future addFavorite() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("tamadun-users-favorites");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("favorite-items")
        .doc()
        .set({
      "info-title": widget._monathestic["info-title"],
      "info-sub": widget._monathestic["info-sub"],
      "info-img": widget._monathestic["info-img"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Added to Favourite!'))));
  }

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message,
        subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  //todo: get surah id from before-creation @ before-exist db
  final List _suraList = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  getSurah() async {
    List surahid = widget._monathestic["desc-id"];
    surahid.forEach((element) {
      getTafsir(element);
    });
  }

  bool _isloading = false;

  @override
  void initState() {
    _isloading = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isloading = false;
      });
    });

    getSurah();
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
            title: Text(
              widget._monathestic['info-title'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "MontserratBold",
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black,
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                });
              },
            ),

            //todo: favorite button
            actions: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("tamadun-users-favorites")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("favorite-items")
                    .where("info-title",
                    isEqualTo: widget._monathestic['info-title'])
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Text("");
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () => snapshot.data.docs.length == 0
                          ? addFavorite()
                          : print("Already added"),
                      icon: snapshot.data.docs.length == 0
                          ? const Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      )
                          : const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(
                  context,
                ),
              ),
            ]),
        body: screenWidth < 576
            ? _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(hexColor('#25346a'),
              ),
            )
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:
                Image.network(widget._monathestic['info-img'][0],),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-sub'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 1,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-desc'][0],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._monathestic['info-surah'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._monathestic['info-surah_name'][0],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._monathestic['trans-text'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._monathestic['info-translation'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  for (int sura = 0;
                  sura < _suraList.length;
                  sura++) ...[
                    for (int tafsir = 0;
                    tafsir <
                        _suraList[sura]["info-mini-title"].length;
                    tafsir++) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "${_suraList[sura]["info-mini-title"][tafsir]}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "${_suraList[sura]["info-desc"][tafsir]}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ]
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                          onPressed: () => null,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                          onPressed: () {
                            final monathestic = FirebaseFirestore
                                .instance
                                .collection('monathestic-empire');
                            monathestic
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _monathestic = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._monathestic[
                                      "info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoMonathestic(
                                                    _monathestic)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        )

            : screenWidth < 992 ? _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(hexColor('#25346a'),
              ),
            )
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child:
                Image.network(widget._monathestic['info-img'][0],),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-sub'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 1,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._monathestic['info-desc'][0],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._monathestic['info-surah'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._monathestic['info-surah_name'][0],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._monathestic['trans-text'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._monathestic['info-translation'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  for (int sura = 0;
                  sura < _suraList.length;
                  sura++) ...[
                    for (int tafsir = 0;
                    tafsir <
                        _suraList[sura]["info-mini-title"].length;
                    tafsir++) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "${_suraList[sura]["info-mini-title"][tafsir]}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "${_suraList[sura]["info-desc"][tafsir]}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ]
                  ],
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
                            'Description',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                          onPressed: () => null,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                          onPressed: () {
                            final monathestic = FirebaseFirestore
                                .instance
                                .collection('monathestic-empire');
                            monathestic
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _monathestic = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._monathestic[
                                      "info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoMonathestic(
                                                    _monathestic)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ):null
    );
  }

  //todo: get tafsir info & name
  void getTafsir(element) async {
    DocumentSnapshot qnSurah =
    await _firestoreInstance.collection("desc").doc(element).get();
    setState(() {
      _suraList.add({
        "info-desc": qnSurah["info-desc"],
        "info-mini-title": qnSurah["info-mini-title"],
      });
    });
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