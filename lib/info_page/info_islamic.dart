import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../info_video/info_video-islamic.dart';

class InfoHomosapiens extends StatefulWidget {
  final _homosapiens;
  const InfoHomosapiens(this._homosapiens);
  @override
  State<InfoHomosapiens> createState() => _InfoHomosapiensState();
}

class _InfoHomosapiensState extends State<InfoHomosapiens> {
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

  bool isReadmore = false;
  bool _isloading = false;

  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._homosapiens['info-title'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                onPressed: () => share(
                  context,
                ),
              ),
            ]),
        body: _isloading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )
            : SingleChildScrollView(
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
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-desc'][0],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['info-surah'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['info-surah_name'][0],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['trans-text'][0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:
                    Text(widget._homosapiens['info-translation'][0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-desc'][1],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['info-surah'][1],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['info-surah_name'][1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._homosapiens['trans-text'][1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:
                    Text(widget._homosapiens['info-translation'][1],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-desc'][2],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._homosapiens['info-desc'][3],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: Text(
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
                          child: Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                          onPressed: () {
                            final homosapiens = FirebaseFirestore.instance
                                .collection('first-man-on-earth');
                            homosapiens
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _homosapiens = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._homosapiens["info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoHomosapiens(
                                                    _homosapiens)));
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
        ));
  }
}
