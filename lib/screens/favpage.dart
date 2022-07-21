import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_page/info_islamic.dart';
import 'package:tamadun/info_page/info_living_things.dart';

import '../info_page/info-theexistence.dart';
import '../info_page/info_beforebigbang.dart';
import '../info_page/info_empier.dart';
import 'home_page.dart';

// final before = FirebaseFirestore.instance.collection('before-the-existence');
// final exist = FirebaseFirestore.instance.collection('the-existence');
// final favitem = FirebaseFirestore.instance.collection('favorite-items');

class FavScreenTwo extends StatefulWidget {
  const FavScreenTwo({Key? key}) : super(key: key);

  @override
  State<FavScreenTwo> createState() => _FavScreenTwoState();
}

class _FavScreenTwoState extends State<FavScreenTwo> {
  //  final List _beforeExist = [];
  //
  // Future<void> getuserfav() async{
  //   final before = FirebaseFirestore.instance.collection('before-the-existence');
  //   final exist = FirebaseFirestore.instance.collection('the-existence');
  //
  //   before.get().then((QuerySnapshot snapshot) {
  //       snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
  //         if (snapshot.docs.isNotEmpty) {
  //           print(documentSnapshot.data());
  //         }  else{
  //           print("Data Not Found");
  //         }
  //       });
  //
  //   });
  // }
  //
  //  @override
  //  void initState() {
  //    // TODO: implement initState
  //    getuserfav();
  //    super.initState();
  //  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "User Favorite",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("tamadun-users-favorites")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("favorite-items") //changed
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something is wrong!"),
                );
              }
              else if(snapshot.data == null){
                return const Center(
                  child: Text("You haven’t favorited anything yet.\nBrowse to an event in the timeline and tap save icon to save something in this list.",style: TextStyle(
                  fontFamily: 'PoppinsLight',
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,),
                );
              }
              return Material(
                child: ListView.builder(
                    itemCount:
                        snapshot.data == null ? 0 : snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[index];
                      return GestureDetector(
                        //todo: when user click on the favorites item it will redirect user to info page
                        onTap: () async {
                          //doc is fetch from specific firebase based on the title
                          //_documentSnapshot is from tamadun-users-favorite

                          //todo:Before The Existence
                          final before = FirebaseFirestore.instance
                              .collection('before-the-existence');
                          before.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _beforeExist = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_beforeExist.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoBeforeExistence(
                                                  _beforeExist)));
                                }
                              });
                            });
                          });

                          //todo:The Existence
                          final exist = FirebaseFirestore.instance
                              .collection('the-existence-of-universe');
                          exist.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _theExist = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_theExist.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoTheExistence(_theExist)));
                                }
                              });
                            });
                          });

                          //todo: Homosapiens
                          final homosapiens = FirebaseFirestore.instance
                              .collection('first-man-on-earth');
                          homosapiens.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _homosapiens = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_homosapiens.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoHomosapiens(_homosapiens)));
                                }
                              });
                            });
                          });

                          //todo: living_things
                          final living_things = FirebaseFirestore.instance
                              .collection('living-things');
                          living_things.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _livingthings = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_livingthings.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoLivingThings(_livingthings)));
                                }
                              });
                            });
                          });

                          //todo: Glorious of Empire Islam
                          final glorious = FirebaseFirestore.instance
                              .collection('the-islamic-empire');
                          glorious.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _empire = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_empire.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoEmpire(_empire)));
                                }
                              });
                            });
                          });
                        },
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.all(5),
                          //color: Colors.purple[50],
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  _documentSnapshot['info-img'][0]),
                            ),
                            title: Text(_documentSnapshot['info-title']),
                            subtitle: Text(
                              _documentSnapshot['info-sub'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("tamadun-users-favorites")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection("favorite-items")
                                      .doc(_documentSnapshot.id)
                                      .delete()
                                      .then((value) =>
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                      'Remove Successfully'))));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                )),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
