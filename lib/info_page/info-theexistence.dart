import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../info_video/info_video_theexistence.dart';

class InfoTheExistence extends StatefulWidget {
  final _theExist;

  const InfoTheExistence(this._theExist);

  @override
  State<InfoTheExistence> createState() => _InfoTheExistenceState();
}

class _InfoTheExistenceState extends State<InfoTheExistence> {
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

  void share(BuildContext context){
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  var _firestoreInstance = FirebaseFirestore.instance;

  final List _tafserList = [];

  Future<void> getTafser() async {
    for (var item in tafserid) {
      await getTafserList(item);
    }
  }

  late List tafserid;
  bool _isloading = false;
  @override
  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 5),(){
      setState((){
        _isloading=false;
      });
    });

    tafserid = widget._theExist["surah-id"];
    getTafser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._theExist['info-title'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                icon: Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(context, ),
              ),
            ]),
        body:_isloading ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ): SingleChildScrollView(
          child: Column(children: [
            Container(
              child: Image.network(widget._theExist['info-img'][0]),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
                padding: EdgeInsets.all(10),
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(widget._theExist['info-desc'][0],textAlign:TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  for (int sura = 0;
                  sura < widget._theExist['info-surah'].length;
                  sura++) ...[
                    Column(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._theExist['info-surah'][sura],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'PoppinsThin',
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._theExist['info-surah_name'][sura],textAlign:TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text("Translation: ",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsLight',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._theExist['info-translation'][sura],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      for (int tafsir = 0;
                      tafsir < _tafserList[sura]['tafseer-info'].length;
                      tafsir++)
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey),
                          ),
                          child: ExpansionTile(
                            title: Text(
                                "${_tafserList[sura]['tafseer-name'][tafsir]}",
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'PoppinsMedium',
                                  color: Colors.black,
                                )),
                            //contents
                            children: [
                              ListTile(
                                title: Text(
                                    "${_tafserList[sura]['tafseer-info'][tafsir]}",textAlign:TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontFamily: 'PoppinsLight',
                                      color: Colors.black,
                                    )),
                              )
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ])
                  ],
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
                            final before = FirebaseFirestore.instance
                                .collection('the-existence-of-universe');
                            before.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final _theExist = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._theExist["info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoExistence(_theExist)));
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
                ])),
          ]),
        ));
  }

  getTafserList(element) async {
    await _firestoreInstance
        .collection("surah")
        .doc(element)
        .get()
        .then((value) {
      setState(() {
        _tafserList.add({
          "tafseer-info": value["list-tafsir-info"],
          "tafseer-name": value["list-tafsir-name"],
          "id": value.id
        });
      });
    });
  }
}
