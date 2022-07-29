import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../info_video/info_video_beforebigbang.dart';

class InfoBeforeExistence extends StatefulWidget {
  final _beforeExist;
  const InfoBeforeExistence(this._beforeExist);

  @override
  State<InfoBeforeExistence> createState() => _InfoBeforeExistenceState();
}

class _InfoBeforeExistenceState extends State<InfoBeforeExistence> {
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

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  //todo: get surah id from before-creation @ before-exist db
  final List _suraList = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  getSurah() async {
    List surahid = widget._beforeExist["surah-id"];
    surahid.forEach((element) {
      getTafsir(element);
    });
  }

  @override
  void initState() {
    getSurah();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._beforeExist['info-title'],
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
              IconButton(
                icon: Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(context,),
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(children: [
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
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget._beforeExist['info-sub'],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),

                const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 1,
                ),
                Align(
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
                  child: Text(widget._beforeExist['info-desc'],textAlign:TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsRegular',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-surah'][0],textAlign:TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-surah_name'][0],textAlign:TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['trans-text'][0],textAlign:TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-translation'][0],textAlign:TextAlign.justify,
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

                for (int sura = 0; sura < _suraList.length; sura++) ...[
                  for (int tafsir = 0; tafsir < _suraList[sura]["list-tafsir-name"].length; tafsir++) ...[
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: ExpansionTile(title:Text("${_suraList[sura]["list-tafsir-name"][tafsir]}",
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'PoppinsRegular',
                            color: Colors.black,
                          )),
                        //contents
                        children: [
                          ListTile(
                            title: Text("${_suraList[sura]["list-tafsir-info"][tafsir]}",textAlign:TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'PoppinsLight',
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                    ),
                  ]
                ],

                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-surah'][1],textAlign:TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-surah_name'][1],textAlign:TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['trans-text'][1],textAlign:TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._beforeExist['info-translation'][1],textAlign:TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),

                //todo: video button
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
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
                      child: RaisedButton(
                        child: Text('Video',style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                        ),),
                        onPressed: () {
                          final before = FirebaseFirestore.instance
                              .collection('before-the-existence');
                          before.get().then((QuerySnapshot snapshot) {
                            snapshot.docs.forEach((DocumentSnapshot doc) {
                              final _beforeExist = doc;
                              setState(() {
                                if (doc["info-title"] == widget._beforeExist["info-title"]) {
                                  print(widget._beforeExist["info-video"]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoBeforeExistence(_beforeExist)));
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
            )
          ]),
        ));
  }

  //todo: get tafsir info & name
  void getTafsir(element) async {
    DocumentSnapshot qnSurah =
    await _firestoreInstance.collection("surah").doc(element).get();
    setState(() {
      _suraList.add({
        "list-tafsir-info": qnSurah["list-tafsir-info"],
        "list-tafsir-name": qnSurah["list-tafsir-name"],
      });
    });
  }
}

// import 'package:tamadun/info_page/video.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tamadun/info_video/info_video_beforebigbang.dart';
// import 'package:tamadun/screens/home_page.dart';
//
// class InfoBeforeExistence extends StatefulWidget {
//   final _beforeExist;
//   const InfoBeforeExistence(this._beforeExist);
//   @override
//   State<InfoBeforeExistence> createState() => _InfoBeforeExistenceState();
// }
//
// class _InfoBeforeExistenceState extends State<InfoBeforeExistence> {
//   //todo: add favorite function
//   Future addFavorite() async {
//     final FirebaseAuth auth = FirebaseAuth.instance;
//     var currentUser = auth.currentUser;
//     CollectionReference _collectionRef =
//     FirebaseFirestore.instance.collection("tamadun-users-favorites");
//     return _collectionRef
//         .doc(currentUser!.email)
//         .collection("favorite-items")
//         .doc()
//         .set({
//       "info-title": widget._beforeExist["info-title"],
//       "info-sub": widget._beforeExist["info-sub"],
//       "info-img": widget._beforeExist["info-img"],
//     }).then((value) => ScaffoldMessenger.of(context)
//         .showSnackBar( const SnackBar(
//         duration: Duration(seconds: 1),
//         content: Text(
//             'Added to Favourite!'))));
//   }
//
//   bool isReadmore= false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(
//             widget._beforeExist['info-title'],
//             maxLines:3,
//             overflow:TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 18.0,
//               fontFamily: 'PoppinsMedium',
//               color: Colors.black,
//             ),
//           ),
//           backgroundColor: Colors.white54,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios_rounded),
//             color: Colors.black,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//
//           //todo: favorite button
//           actions: [
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("tamadun-users-favorites")
//                   .doc(FirebaseAuth.instance.currentUser!.email)
//                   .collection("favorite-items")
//                   .where("info-title",
//                   isEqualTo: widget._beforeExist['info-title'])
//                   .snapshots(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.data == null) {
//                   return const Text("");
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: IconButton(
//                     onPressed: () => snapshot.data.docs.length == 0
//                         ? addFavorite()
//                         : print("Already added"),
//                     icon: snapshot.data.docs.length == 0
//                         ? const Icon(
//                       Icons.favorite_outline,
//                       color: Colors.black,
//                     )
//                         : const Icon(
//                       Icons.favorite,
//                       color: Colors.pink,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               child: Image.network(widget._beforeExist['info-img'][0]),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(children: <Widget>[
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget._beforeExist['info-title'],
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget._beforeExist['info-sub'],
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                   height: 10,
//                   indent: 5,
//                   endIndent: 5,
//                   thickness: 1,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text("Description",
//                       style: const TextStyle(
//                         fontSize: 20.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//
//
//
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget._beforeExist['info-desc'],textAlign:TextAlign.justify,
//                       style: const TextStyle(
//                         fontSize: 15.0,
//                         fontFamily: 'PoppinsLight',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah'][0],
//                       style: const TextStyle(
//                         fontSize: 18.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah_name'][0],
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text("Translation: ",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-translation'][0],textAlign:TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                 Card(
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                       side: BorderSide(color: Colors.grey),
//                   ),
//                   child: ExpansionTile(
//                     title: Text(widget._beforeExist['tafsir-text'][0],
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                     // Contents
//                     children: [
//                       ListTile(
//                         title: Text(widget._beforeExist['info-tafsir-name'][0],
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontFamily: 'PoppinsMedium',
//                               color: Colors.black,
//                             )),
//                         subtitle: Text(widget._beforeExist['info-tafsir'][0],textAlign:TextAlign.justify,style: const TextStyle(
//                           fontSize: 15.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),),
//                       ListTile(
//                         title: Text(widget._beforeExist['info-tafsir-name'][1],
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontFamily: 'PoppinsMedium',
//                               color: Colors.black,
//                             )),
//                         subtitle: Text(widget._beforeExist['info-tafsir'][1],textAlign:TextAlign.justify,style: const TextStyle(
//                           fontSize: 15.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),),
//                       ListTile(
//                         title: Text(widget._beforeExist['info-tafsir-name'][2],
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontFamily: 'PoppinsMedium',
//                               color: Colors.black,
//                             )),
//                         subtitle: Text(widget._beforeExist['info-tafsir'][2],textAlign:TextAlign.justify,style: const TextStyle(
//                           fontSize: 15.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),),
//                       ListTile(
//                         title: Text(widget._beforeExist['info-tafsir-name'][3],
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               fontFamily: 'PoppinsMedium',
//                               color: Colors.black,
//                             )),
//                         subtitle: Text(widget._beforeExist['info-tafsir'][3],textAlign:TextAlign.justify,style: const TextStyle(
//                           fontSize: 15.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 //todo: second surah here
//
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah'][1],textAlign:TextAlign.right,
//                       style: const TextStyle(
//                         fontSize: 18.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah_name'][1],textAlign:TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['trans-text'][1],textAlign:TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-translation'][1],textAlign:TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 //todo: third surah here
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah'][2],textAlign:TextAlign.justify,
//                       style: const TextStyle(
//                         fontSize: 18.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-surah_name'][2],
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['trans-text'][2],textAlign:TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Text(widget._beforeExist['info-translation'][2],textAlign:TextAlign.justify,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         fontStyle: FontStyle.italic,
//                         color: Colors.black,
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//
//
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: RaisedButton(
//                         child: Text('Description',style: TextStyle(
//                           color: Colors.white,
//                         ),),
//                         onPressed: () => null,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Expanded(
//                       child: RaisedButton(
//                         child: Text('Video',style: TextStyle(
//                           color: Colors.white,
//                         ),),
//                         onPressed: () {
//                           final before = FirebaseFirestore.instance
//                               .collection('before-the-existence');
//                           before.get().then((QuerySnapshot snapshot) {
//                             snapshot.docs.forEach((DocumentSnapshot doc) {
//                               final _beforeExist = doc;
//                               setState(() {
//                                 if (doc["info-title"] == widget._beforeExist["info-title"]) {
//                                   print(widget._beforeExist["info-video"][0]);
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               VideoBeforeExistence(_beforeExist)));
//                                 }
//                               });
//                             });
//                           });
//                         },
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 //
//                 // MaterialButton(
//                 //   shape: RoundedRectangleBorder(
//                 //     borderRadius: BorderRadius.circular(10.0),
//                 //   ),
//                 //   elevation: 0,
//                 //   color: Colors.blue[200],
//                 //   minWidth: double.maxFinite,
//                 //   height: 50,
//                 //   onPressed: () {
//                 //     Navigator.of(context).push(MaterialPageRoute(
//                 //         builder: (context) => FavScreenTwo()));
//                 //   },
//                 //   child: const Text('Favorite',
//                 //       style: TextStyle(
//                 //           color: Colors.black,
//                 //           fontFamily: 'PoppinsMedium',
//                 //           fontSize: 16)),
//                 // ),
//                 //
//                 // SizedBox(
//                 //   height: 5,
//                 // )
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
