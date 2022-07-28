import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  //todo: get surah id from before-creation @ before-exist db

  var _firestoreInstance = FirebaseFirestore.instance;

  final List _tafserList = [];

  Future<void> getTafser() async {
    for (var item in tafserid) {
      await getTafserList(item);
    }
  }

  late List tafserid;

  @override
  void initState() {
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
            ]),
        body: widget._theExist['info-surah'].length != _tafserList.length
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                  Container(
                    child: Image.network(widget._theExist['info-img'][0]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(widget._theExist['info-title'],
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'PoppinsMedium',
                            color: Colors.black,
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
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
                      indent: 5,
                      endIndent: 5,
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
                    for (int sura = 0;
                        sura < widget._theExist['info-surah'].length;
                        sura++) ...[
                      Column(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(widget._theExist['info-surah'][sura],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'PoppinsMedium',
                                color: Colors.black,
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(widget._theExist['info-surah_name'][sura],
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'PoppinsMedium',
                                color: Colors.black,
                              )),
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
                                    fontFamily: 'PoppinsLight',
                                    color: Colors.black,
                                  )),
                              //contents
                              children: [
                                ListTile(
                                  title: Text(
                                      "${_tafserList[sura]['tafseer-info'][tafsir]}",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'PoppinsLight',
                                        color: Colors.black,
                                      )),
                                )
                              ],
                            ),
                          )
                      ])
                    ],
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              final before = FirebaseFirestore.instance
                                  .collection('the-existence-of-universe');
                              before.get().then((QuerySnapshot snapshot) {
                                snapshot.docs.forEach((DocumentSnapshot doc) {
                                  final _theExist = doc;
                                  setState(() {
                                    if (doc["info-title"] ==
                                        widget._theExist["info-title"]) {
                                      print(widget._theExist["info-video"][0]);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             VideoTheExist(_theExist)));
                                    }
                                  });
                                });
                              });
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Text("Video",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'PoppinsMedium',
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    )
                  ])
                ]),
              ));
  }

  getTafserList(element) async {
    await _firestoreInstance
        .collection("surah")
        .doc(element)
        .get()
        .then((value) {
      print(value.id);
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
