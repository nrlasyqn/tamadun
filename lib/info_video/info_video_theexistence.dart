import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/info-theexistence.dart';
import 'package:tamadun/info_page/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../info_page/info_beforebigbang.dart';
import '../timeline/timeline_beforebigbang.dart';

class VideoExistence extends StatefulWidget {
  final _theExist;
  const VideoExistence(this._theExist);

  @override
  State<VideoExistence> createState() => _VideoExistenceState();
}

class _VideoExistenceState extends State<VideoExistence> {
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
      "info-title": widget._theExist["info-title"],
      "info-sub": widget._theExist["info-sub"],
      "info-img": widget._theExist["info-img"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Added to Favourite!'))));
  }

  void share(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String message = 'Check out this useful content! https://play.google.com/store/apps/details?id=com.aqwise.ummahempire';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message,
      subject: 'Description',
      sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height /2 ),);
    //sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  getSurah() async {
    List _videoid = widget._theExist["video-id"];
    _videoid.forEach((element) {
      getTafsir(element);
    });
  }

  final List _videoList = [];
  var _firestoreInstance = FirebaseFirestore.instance;
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
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              widget._theExist['info-title'],
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
                    isEqualTo: widget._theExist['info-title'])
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
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._theExist['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-sub'],
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

                  //todo: insert video here
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Video',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  for (int vid_id = 0;
                  vid_id < _videoList.length;
                  vid_id++) ...[
                    for (int vid_coll = 0;
                    vid_coll <
                        _videoList[vid_id]["info-video"].length;
                    vid_coll++)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 300,
                              child: VideoPlayer(
                                videoData:
                                ("${_videoList[vid_id]["info-video"][vid_coll]}"),
                              ),
                            )),
                      ),
                  ],

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
                          onPressed: () {
                            final exist = FirebaseFirestore.instance
                                .collection(
                                'the-existence-of-universe');
                            exist
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _theExist = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget
                                          ._theExist["info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InfoTheExistence(
                                                    _theExist)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
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
                          onPressed: () => null,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )

                  //
                  // MaterialButton(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   elevation: 0,
                  //   color: Colors.blue[200],
                  //   minWidth: double.maxFinite,
                  //   height: 50,
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => FavScreenTwo()));
                  //   },
                  //   child: const Text('Favorite',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontFamily: 'PoppinsMedium',
                  //           fontSize: 16)),
                  // ),
                  //
                  // SizedBox(
                  //   height: 5,
                  // )
                ]),
              ),
            ],
          ),
        )
            : screenWidth < 2800
            ? _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._theExist['info-img'][0],
                  width: 700,
                  fit:BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-title'],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-sub'],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 1,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //todo: insert video here
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Video',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  for (int vid_id = 0; vid_id < _videoList.length; vid_id++) ...[
                    for (int vid_coll = 0; vid_coll < _videoList[vid_id]["info-video"].length; vid_coll++)
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 500,
                              width: 800,
                              child: VideoPlayer(
                                videoData:
                                ("${_videoList[vid_id]["info-video"][vid_coll]}"),
                              ),
                            )),
                      ),
                  ],

                  const SizedBox(
                    height: 30,
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
                          onPressed: () {
                            final exist = FirebaseFirestore
                                .instance
                                .collection(
                                'the-existence-of-universe');
                            exist
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach(
                                      (DocumentSnapshot doc) {
                                    final _theExist = doc;
                                    setState(() {
                                      if (doc["info-title"] ==
                                          widget._theExist[
                                          "info-title"]) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InfoTheExistence(
                                                        _theExist)));
                                      }
                                    });
                                  });
                            });
                          },
                          color: Colors.grey,
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
                          onPressed: () => null,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )

                  //
                  // MaterialButton(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //   ),
                  //   elevation: 0,
                  //   color: Colors.blue[200],
                  //   minWidth: double.maxFinite,
                  //   height: 50,
                  //   onPressed: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => FavScreenTwo()));
                  //   },
                  //   child: const Text('Favorite',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontFamily: 'PoppinsMedium',
                  //           fontSize: 16)),
                  // ),
                  //
                  // SizedBox(
                  //   height: 5,
                  // )
                ]),
              ),
            ],
          ),
        )
            : null);
  }

  void getTafsir(element) async {
    DocumentSnapshot qnVideo =
    await _firestoreInstance.collection("video").doc(element).get();
    setState(() {
      _videoList.add({
        "info-video": qnVideo["info-video"],
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
