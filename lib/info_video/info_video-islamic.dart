import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/info_islamic.dart';
import 'package:tamadun/info_page/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../timeline/timeline_beforebigbang.dart';

class VideoHomosapiens extends StatefulWidget {
  final _homosapiens;
  const VideoHomosapiens(this._homosapiens);

  @override
  State<VideoHomosapiens> createState() => _VideoHomosapiensState();
}

class _VideoHomosapiensState extends State<VideoHomosapiens> {
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
      "info-title": widget._homosapiens["info-title"],
      "info-sub": widget._homosapiens["info-sub"],
      "info-img": widget._homosapiens["info-img"],
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar( const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
            'Added to Favourite!'))));
  }

  void share(BuildContext context){
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Description',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._homosapiens['info-title'],
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white54,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
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
                    isEqualTo: widget._homosapiens['info-title'])
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
                icon: Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(context, ),
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._homosapiens['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-sub'],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 25,
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                  ),
                  //todo: insert video here
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Video',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 300,
                    child: VideoPlayer(
                      videoData: widget._homosapiens['info-video'][0],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text('Description',style: TextStyle(
                            color: Colors.white,
                          ),),
                          onPressed: () {
                            final homosapiens = FirebaseFirestore.instance
                                .collection('first-man-on-earth');
                            homosapiens.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final _homosapiens = doc;
                                setState(() {
                                  if (doc["info-title"] == widget._homosapiens["info-title"]) {
                                    print(widget._homosapiens["info-video"][0]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InfoHomosapiens(_homosapiens)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text('Video',style: TextStyle(
                            color: Colors.white,
                          ),),
                          onPressed: () {
                          },
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  /*   Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Kindacode.com'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                            fixedSize: const Size(300, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Kindacode.com'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            fixedSize: const Size(300, 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ],
                  ),*/

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
        ));
  }
}