import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:tamadun/info_page/video.dart';

import '../info_page/info_ummah.dart';


class VideoUmmah extends StatefulWidget {
  final _ummah;
  const VideoUmmah(this._ummah);

  @override
  State<VideoUmmah> createState() => _VideoUmmahState();
}

class _VideoUmmahState extends State<VideoUmmah> {
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
      "info-title": widget._ummah["info-title"],
      "info-sub": widget._ummah["info-sub"],
      "info-img": widget._ummah["info-img"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Added to Favourite!'))));
  }

  void share(BuildContext context){
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Description',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  getSurah() async{
    List _videoid = widget._ummah["video-id"];
    _videoid.forEach((element) {
      getTafsir(element);

    });
  }

  final List _videoList = [];
  var _firestoreInstance = FirebaseFirestore.instance;
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
              widget._ummah['info-title'],
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
                    isEqualTo: widget._ummah['info-title'])
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
          child: Column(
              children: [
                Container(
                  child: Image.network(widget._ummah['info-img'][0]),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget._ummah['info-title'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'PoppinsMedium',
                            color: Colors.black,
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(widget._ummah['info-sub'],
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



                    /*//todo: check if retrieve surah from db success or not
                    for (int a = 0;a<_videoList[a]["info-video"].length;  a++)
                      Container(
                        height: 300,
                        alignment: Alignment.centerLeft,
                        child: VideoPlayer(
                          videoData: ("${_videoList[a]["info-video"]}"
                          ),

                        ),),

                    for (int b = 0;b<_videoList[b]["info-video"].length;  b++)
                      Container(
                        height: 300,
                        alignment: Alignment.centerLeft,
                        child: VideoPlayer(
                          videoData: ("${_videoList[b]["info-video"]}"
                          ),

                        ),),*/
                    for (int vid_id = 0; vid_id < _videoList.length; vid_id++) ...[
                      for (int vid_coll = 0; vid_coll < _videoList[vid_id]["info-video"].length; vid_coll++)
                        Padding(
                          padding: EdgeInsets.all(5),
                          child:  Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 300,
                                child: VideoPlayer(
                                  videoData: ("${_videoList[vid_id]["info-video"][vid_coll]}"),
                                ),
                              )),
                        ),
                    ],

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text('Description',style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),),

                            onPressed: () async{
                              final ummah = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
                              ummah.get().then((QuerySnapshot snapshot) {
                                snapshot.docs.forEach((DocumentSnapshot doc) {
                                  final _ummah = doc;
                                  setState(() {
                                    if (doc["info-title"] == widget._ummah["info-title"]) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TheProphet(_ummah)));
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
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),),
                            onPressed: () => null,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                    //
                    // Text("*list-tafsir-name*"),
                    // for(int b=0; b<_suraList.length; b++)
                    //   Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text("${_suraList[b]["list-tafsir-name"]}",
                    //         style: const TextStyle(
                    //           fontSize: 15.0,
                    //           fontFamily: 'PoppinsLight',
                    //           color: Colors.black,
                    //         )),
                    //   ),

                    // SizedBox(height: 10),
                    // for (int i = 0; i < widget._beforeExist['info-surah'].length; i++)
                    //   Column(
                    //       children: [
                    //         Align(
                    //           alignment: Alignment.center,
                    //           child: Text(widget._beforeExist['info-surah'][i],
                    //               style: const TextStyle(
                    //                 fontSize: 18.0,
                    //                 fontFamily: 'PoppinsMedium',
                    //                 color: Colors.black,
                    //               )),
                    //         ),

                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text(widget._beforeExist['surah-id'][i],
                    //       style: const TextStyle(
                    //         fontSize: 18.0,
                    //         fontFamily: 'PoppinsMedium',
                    //         color: Colors.black,
                    //       )),
                    // ),

                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.stretch,
                    //               children: <Widget>[
                    //                 MaterialButton(
                    //                   onPressed: () {
                    //                     //todo:Before The Existence
                    //                     final before = FirebaseFirestore.instance
                    //                         .collection('before-the-existence');
                    //                     before.get().then((QuerySnapshot snapshot) {
                    //                       snapshot.docs.forEach((DocumentSnapshot doc) {
                    //                         final _beforeExist = doc;
                    //                         setState(() {
                    //                           if (doc["info-title"] ==
                    //                               widget._beforeExist["info-title"]) {
                    //                             print(widget._beforeExist["info-video"]);
                    //                             Navigator.push(
                    //                                 context,
                    //                                 MaterialPageRoute(
                    //                                     builder: (context) =>
                    //                                         VideoBeforeExistence(
                    //                                             _beforeExist)));
                    //                           }
                    //                         });
                    //                       });
                    //                     });
                    //                   },
                    //                   child: Text("Video"),
                    //                   color: CupertinoColors.systemGrey5,
                    //                 ),
                    //                 MaterialButton(
                    //                   color: Colors.black12,
                    //                   onPressed: () {},
                    //                   child: Text(
                    //                     "Description",
                    //                     style: TextStyle(color: Colors.white),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //
                    //             SizedBox(
                    //               height: 5,
                    //             )
                    // Container(
                    //   margin: EdgeInsets.only(top:8),
                    //   child: new ButtonBar(
                    //     alignment: MainAxisAlignment.center,
                    //     children:<Widget>[
                    //
                    //       MaterialButton(
                    //         onPressed:(){
                    //           final before = FirebaseFirestore.instance
                    //               .collection('living-things');
                    //           before.get().then((QuerySnapshot snapshot) {
                    //             snapshot.docs.forEach((DocumentSnapshot doc) {
                    //               final _beforeExist = doc;
                    //               setState(() {
                    //                 if (doc["info-title"] ==
                    //                     widget._ummah["info-title"]) {
                    //                   print(widget._ummah["info-video"][0]);
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) =>
                    //                               VideoTheExist(
                    //                                   _beforeExist)));
                    //                 }
                    //               });
                    //             });
                    //           });
                    //         },
                    //         child: Text("Description",
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //               fontSize:16.0,
                    //               fontFamily: 'PoppinsMedium',
                    //               color: Colors.white,)),
                    //         color: Colors.black,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //         ),
                    //       ),
                    //
                    //       // MaterialButton(
                    //       //   onPressed:(){
                    //       //     final before = FirebaseFirestore.instance
                    //       //         .collection('living-things');
                    //       //     before.get().then((QuerySnapshot snapshot) {
                    //       //       snapshot.docs.forEach((DocumentSnapshot doc) {
                    //       //         final _beforeExist = doc;
                    //       //         setState(() {
                    //       //           if (doc["info-title"] ==
                    //       //               widget._ummah["info-title"]) {
                    //       //             print(widget._livingthings["info-video"][0]);
                    //       //             Navigator.push(
                    //       //                 context,
                    //       //                 MaterialPageRoute(
                    //       //                     builder: (context) =>
                    //       //                         VideolivingThings(
                    //       //                             _beforeExist)));
                    //       //           }
                    //       //         });
                    //       //       });
                    //       //     });
                    //       //   },
                    //       //   child: Text("Video",
                    //       //       textAlign: TextAlign.center,
                    //       //       style: TextStyle(
                    //       //         fontSize:16.0,
                    //       //         fontFamily: 'PoppinsMedium',
                    //       //         color: Colors.white,)),
                    //       //   color: Colors.grey,
                    //       //   shape: RoundedRectangleBorder(
                    //       //     borderRadius: BorderRadius.circular(10.0),
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // )
                  ]),
                )
              ]),
        )
    );
  }

  void getTafsir(element) async{
    DocumentSnapshot qnVideo =
    await _firestoreInstance.collection("video").doc(element).get();
    setState((){
      _videoList.add({
        "info-video":qnVideo["info-video"],
      });
    });
  }
}

// import 'package:share_plus/share_plus.dart';
// import 'package:tamadun/info_page/video.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../info_page/info_beforebigbang.dart';
// import '../info_page/info_ummah.dart';
// import '../timeline/timeline_beforebigbang.dart';
//
// class VideoUmmah extends StatefulWidget {
//   final _ummah;
//   const VideoUmmah(this._ummah);
//
//   @override
//   State<VideoUmmah> createState() => _VideoUmmahState();
// }
//
// class _VideoUmmahState extends State<VideoUmmah> {
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
//       "info-title": widget._ummah["info-title"],
//       "info-sub": widget._ummah["info-sub"],
//       "info-img": widget._ummah["info-img"],
//     }).then((value) => ScaffoldMessenger.of(context)
//         .showSnackBar( const SnackBar(
//         duration: Duration(seconds: 1),
//         content: Text(
//             'Added to Favourite!'))));
//   }
//
//   void share(BuildContext context){
//     String message = 'Check out this useful content!';
//     RenderBox? box = context.findRenderObject() as RenderBox;
//
//     Share.share(message, subject: 'Desription',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text(
//               widget._ummah['info-title'],
//               style: const TextStyle(
//                 color: Colors.black,
//               ),
//             ),
//             backgroundColor: Colors.white54,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_rounded),
//               color: Colors.black,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//
//             //todo: favorite button
//             actions: [
//               StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("tamadun-users-favorites")
//                     .doc(FirebaseAuth.instance.currentUser!.email)
//                     .collection("favorite-items")
//                     .where("info-title",
//                     isEqualTo: widget._ummah['info-title'])
//                     .snapshots(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.data == null) {
//                     return const Text("");
//                   }
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: IconButton(
//                       onPressed: () => snapshot.data.docs.length == 0
//                           ? addFavorite()
//                           : print("Already added"),
//                       icon: snapshot.data.docs.length == 0
//                           ? const Icon(
//                         Icons.favorite_outline,
//                         color: Colors.black,
//                       )
//                           : const Icon(
//                         Icons.favorite,
//                         color: Colors.pink,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.share_outlined),
//                 color: Colors.black,
//                 onPressed: () => share(context, ),
//               ),
//             ]),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: Image.network(widget._ummah['info-img'][0]),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               Column(children: <Widget>[
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget._ummah['info-title'],
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(widget._ummah['info-sub'],
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 const Divider(
//                   color: Colors.black,
//                   height: 25,
//                   indent: 5,
//                   endIndent: 5,
//                   thickness: 1,
//                 ),
//                 //todo: insert video here
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Video',
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontFamily: 'PoppinsMedium',
//                         color: Colors.black,
//                       )),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 300,
//                   child: VideoPlayer(
//                     videoData: widget._ummah['info-video'][0],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//
//                 Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: RaisedButton(
//                         child: Text('Description',style: TextStyle(
//                           color: Colors.white,
//                         ),),
//
//                         onPressed: () async{
//                           final ummah = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
//                           ummah.get().then((QuerySnapshot snapshot) {
//                             snapshot.docs.forEach((DocumentSnapshot doc) {
//                               final _ummah = doc;
//                               setState(() {
//                                 if (doc["info-title"] == widget._ummah["info-title"]) {
//                                   print(widget._ummah["info-video"][0]);
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               TheProphet(_ummah)));
//                                 }
//                               });
//                             });
//                           });
//                         },
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Expanded(
//                       child: RaisedButton(
//                         child: Text('Video',style: TextStyle(
//                           color: Colors.white,
//                         ),),
//                         onPressed: () => null,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 )
//
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
//             ],
//           ),
//         ));
//   }
// }
