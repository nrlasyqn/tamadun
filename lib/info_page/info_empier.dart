import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/video.dart';
import 'package:tamadun/info_video/info_video_empier.dart';
import '../timeline/timeline_empier.dart';

class InfoEmpire extends StatefulWidget {
  final _empire;
  const InfoEmpire(this._empire);

  @override
  State<InfoEmpire> createState() => _InfoEmpireState();
}

class _InfoEmpireState extends State<InfoEmpire> {
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
      "info-title": widget._empire["info-title"],
      "info-sub": widget._empire["info-sub"],
      "info-img": widget._empire["info-img"],
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar( const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
            'Added to Favourite!'))));
  }

  void share(BuildContext context){
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  //todo: get surah id from before-creation @ before-exist db
  final List _suraList = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  getSurah() async {
    List surahid = widget._empire["desc-id"];
    surahid.forEach((element) {
      getTafsir(element);
    });
  }
  bool _isloading = false;
  @override
  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 5),(){
      setState((){
        _isloading=false;
      });
    });

    getSurah();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._empire['info-title'],
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
              //todo: timeline empire
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
                    isEqualTo: widget._empire['info-title'])
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
        body: _isloading ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ):SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._empire['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._empire['info-title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._empire['info-sub'],
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
                  SizedBox(height: 16,),
                  for (int sura = 0; sura < _suraList.length; sura++) ...[
                    for (int tafsir = 0; tafsir < _suraList[sura]["info-mini-title"].length; tafsir++) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child:Text("${_suraList[sura]["info-mini-title"][tafsir]}",textAlign:TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'PoppinsRegular',
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 16,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${_suraList[sura]["info-desc"][tafsir]}",textAlign:TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 16,),
                    ]
                  ],

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: Text('Description',style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'PoppinsMedium',
                          ),),
                          onPressed: () => null,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          child: Text('Video',style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: 'PoppinsMedium',
                          ),),
                          onPressed: () {
                            final empire = FirebaseFirestore.instance
                                .collection('the-islamic-empire');
                            empire.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final _empire = doc;
                                setState(() {
                                  if (doc["info-title"] == widget._empire["info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InfoVideoEmpire(_empire)));
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
