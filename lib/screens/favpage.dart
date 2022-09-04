import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_page/info_islamic.dart';
import 'package:tamadun/info_page/info_living_things.dart';
import 'package:tamadun/info_page/info_monathestic.dart';
import 'package:tamadun/info_page/info_ummah.dart';

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
  bool _isloading = false;

  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 1), () {
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
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Favorite",
          style: TextStyle(color: Colors.black,
            fontFamily: "MontserratBold",
            fontSize: 24,
          ),

        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            /* Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));*/
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          },
        ),
      ),
      body: _isloading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(hexColor('#25346a')),
        ),
      )
          : SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("tamadun-users-favorites")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("favorite-items") //changed
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              _isloading = true;
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something is wrong!"),
                );
              } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "You haven’t favorited anything yet.\nBrowse to an event and tap heart icon to save something in this list.",
                    style: TextStyle(
                      fontFamily: 'PoppinsLight',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              // else if (snapshot.data == null){
              //   _isloading = true;
              //   return const Center(
              //     child: Text(""),
              //   );
              // }
              return Material(
                child: ListView.builder(
                    itemCount: snapshot.data == null
                        ? 0
                        : snapshot.data!.docs.length,
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
                                              InfoTheExistence(
                                                  _theExist)));
                                }
                              });
                            });
                          });

                          //todo: Ummah
                          //todo:The Existence
                          final ummah = FirebaseFirestore.instance
                              .collection('ummah')
                              .doc('the-prophets')
                              .collection("prophets-button");
                          ummah.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _ummah = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_ummah.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TheProphet(_ummah)));
                                }
                              });
                            });
                          });

                          //todo: mona
                          final monathestic = FirebaseFirestore.instance
                              .collection('monathestic-empire');
                          monathestic
                              .get()
                              .then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _monathestic = doc;
                              setState(() {
                                if (doc["info-title"] ==
                                    _documentSnapshot["info-title"]) {
                                  print(_documentSnapshot["info-title"]);
                                  print(_documentSnapshot.id);
                                  print(doc["info-title"]);
                                  print(doc.id);
                                  print(_monathestic.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoMonathestic(
                                                  _monathestic)));
                                }
                              });
                            });
                          });

                          //todo: Homosapiens
                          final homosapiens = FirebaseFirestore.instance
                              .collection('first-man-on-earth');
                          homosapiens
                              .get()
                              .then((QuerySnapshot snapshot) {
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
                                              InfoHomosapiens(
                                                  _homosapiens)));
                                }
                              });
                            });
                          });

                          //todo: living_things
                          final living_things = FirebaseFirestore.instance
                              .collection('living-things');
                          living_things
                              .get()
                              .then((QuerySnapshot snapshot) {
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
                                              InfoLivingThings(
                                                  _livingthings)));
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
                            title: Text(_documentSnapshot['info-title'],maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'PoppinsMedium',
                                fontSize: 16,
                                color: Colors.black,
                              ),),
                            subtitle: Text(
                              _documentSnapshot['info-sub'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'PoppinsRegular',
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection(
                                      "tamadun-users-favorites")
                                      .doc(FirebaseAuth
                                      .instance.currentUser!.email)
                                      .collection("favorite-items")
                                      .doc(_documentSnapshot.id)
                                      .delete()
                                      .then((value) => ScaffoldMessenger
                                      .of(context)
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
int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}