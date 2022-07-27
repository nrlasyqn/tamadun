import 'package:tamadun/info_page/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_video/info_video_beforebigbang.dart';

class VideoMonathestic extends StatefulWidget {
  final _monathestic;
  const VideoMonathestic(this._monathestic);
  @override
  State<VideoMonathestic> createState() => _VideoMonathesticState();
}

class _VideoMonathesticState extends State<VideoMonathestic> {
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
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar( const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
            'Added to Favourite!'))));
  }

  bool isReadmore= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget._monathestic['info-title'],
            maxLines:3,
            overflow:TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: 'PoppinsMedium',
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
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(widget._monathestic['info-img'][0]),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._monathestic['info-title'],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._monathestic['info-sub'],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),
                const Divider(
                  color: Colors.black,
                  height: 10,
                  indent: 5,
                  endIndent: 5,
                  thickness: 1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Video",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text('Description',style: TextStyle(
                          color: Colors.white,
                        ),),
                        onPressed: () {
                          final monathestic = FirebaseFirestore.instance
                              .collection('monathestic-empire');
                          monathestic.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _monathestic = doc;
                              setState(() {
                                if (doc["info-title"] == widget._monathestic["info-title"]) {
                                  print(widget._monathestic["info-video"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoBeforeExistence(_monathestic)));
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
      ),
    );
  }
}