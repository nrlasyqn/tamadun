import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_video/info_video_beforebigbang.dart';

class TestInfo extends StatefulWidget {
  final _beforeExist;
  const TestInfo(this._beforeExist);
  @override
  State<TestInfo> createState() => _TestInfoState();
}

class _TestInfoState extends State<TestInfo> {
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
      "info-title": widget._beforeExist["info-title"],
      "info-sub": widget._beforeExist["info-sub"],
      "info-img": widget._beforeExist["info-img"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Added to Favourite!'))));
  }

  bool isReadmore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget._beforeExist['info-title'],
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
                      isEqualTo: widget._beforeExist['info-title'])
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
              child: Image.network(widget._beforeExist['info-img'][0]),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._beforeExist['info-title'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._beforeExist['info-sub'],
                      style: const TextStyle(
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
                  alignment: Alignment.centerLeft,
                  child: Text(widget._beforeExist['info-desc'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                for (int i = 0;
                    i < widget._beforeExist['info-surah'].length;
                    i++)
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._beforeExist['info-surah'][i],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._beforeExist['info-surah_name'][i],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text("Translation: ",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(widget._beforeExist['info-translation'][i],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: ExpansionTile(
                          title: Text(widget._beforeExist['tafsir-text'][i],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'PoppinsMedium',
                                color: Colors.black,
                              )),
                          // Contents
                          children: [
                            for (int ii = 0;
                                ii <
                                    widget._beforeExist['info-tafsir-name']
                                        .length;
                                ii++)
                              ListTile(
                                title: Text(
                                    widget._beforeExist['info-tafsir-name'][ii],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'PoppinsMedium',
                                      color: Colors.black,
                                    )),
                                subtitle:
                                    Text(widget._beforeExist['info-tafsir'][ii],
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: 'PoppinsLight',
                                          color: Colors.black,
                                        )),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        //todo:Before The Existence
                        final before = FirebaseFirestore.instance
                            .collection('before-the-existence');
                        before.get().then((QuerySnapshot snapshot) {
                          snapshot.docs.forEach((DocumentSnapshot doc) {
                            final _beforeExist = doc;
                            setState(() {
                              if (doc["info-title"] ==
                                  widget._beforeExist["info-title"]) {
                                print(widget._beforeExist["info-video"][0]);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoBeforeExistence(
                                                _beforeExist)));
                              }
                            });
                          });
                        });
                      },
                      child: Text("Video"),
                      color: Colors.yellow,
                    ),
                    MaterialButton(
                      color: Colors.deepPurpleAccent,
                      onPressed: () {
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MyApp()));*/
                      },
                      child: Text("Description"),
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
