import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_video/info_video_ummah.dart';

//import '../info-video-beforebigbang.dart';

class TheProphet extends StatefulWidget {
  final _ummah;
  const TheProphet(this._ummah);

  @override
  State<TheProphet> createState() => _TheProphetState();
}

class _TheProphetState extends State<TheProphet> {
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

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  //todo: get surah id from before-creation @ before-exist db
  final List _descList = [];
  final List _histroyList = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  getDesc() async {
    List descid = widget._ummah["desc-id"];
    descid.forEach((element) {
      getInfo(element);
    });
  }

  getHistory() async {
    List historyid = widget._ummah["history-id"];
    historyid.forEach((element) {
      getLesson(element);
    });
  }

  @override
  void initState() {
    getDesc();
    getHistory();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._ummah['info-title'],
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
          child: Column(children: [
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Description",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),
                //TODO:DESCRIPTION OF INFO
                for (int desc = 0; desc < _descList.length; desc++) ...[
                  for (int info = 0; info < _descList[desc]["info-prophet"].length; info++) ...[

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${_descList[desc]["info-prophet"][info]}",textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'PoppinsRegular',
                            color: Colors.black,
                          )
                      ),
                    ),

                  ]
                ],
                const SizedBox(
                  height: 20,
                ),

                SizedBox(height: 10,),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][0],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][0],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][0],textAlign: TextAlign.center,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][0],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][1],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][1],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][1],textAlign: TextAlign.justify,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][1],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][2],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][2],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][2],textAlign: TextAlign.justify,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][2],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][3],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][3],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][3],textAlign: TextAlign.justify,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][3],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][4],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][4],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][4],textAlign: TextAlign.justify,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][4],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][5],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][5],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][5],textAlign: TextAlign.justify,
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
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-mean'][5],textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'PoppinsMedium',
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      )),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah'][6],textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-surah-name'][6],textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsMedium',
                        color: Colors.black,
                      )),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._ummah['info-translation'][6],textAlign: TextAlign.justify,
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


                SizedBox(
                  height: 10,
                ),



                SizedBox(height: 10,),


                //TODO:History OF INFO
                for (int his = 0; his < _histroyList.length; his++) ...[
                  for (int tory = 0; tory < _histroyList[his]["history-title"].length; tory++) ...[
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: ExpansionTile(title:Text("${_histroyList[his]["history-title"][tory]}",
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'PoppinsMedium',
                            color: Colors.black,
                          )),
                        //contents
                        children: [
                          ListTile(
                            title: Text("${_histroyList[his]["history-lesson"][tory]}",textAlign: TextAlign.justify,
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
                        onPressed: () {
                        },
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
                                              VideoUmmah(_ummah)));
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

                const SizedBox(
                  height: 5,
                ),
              ]),
            )
          ]),
        ));
  }

  //todo: get tafsir info & name
  void getInfo(element) async {
    DocumentSnapshot qnDesc =
    await _firestoreInstance.collection("desc").doc(element).get();
    setState(() {
      _descList.add({
        "info-prophet": qnDesc["info-prophet"],


      });
    });
  }
  void getLesson(element) async {
    DocumentSnapshot qnhistory =
    await _firestoreInstance.collection("history").doc(element).get();
    setState(() {
      _histroyList.add({
        "history-title": qnhistory["history-title"],
        "history-lesson": qnhistory["history-lesson"],

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
// //import 'package:tamadun/info_video/info_video_beforebigbang.dart';
//
// //import '../info_video/info_video_ummah.dart';
// import '../info_video/info_video_ummah.dart';
// import '../timeline/timeline_beforebigbang.dart';
//
// class TheProphet extends StatefulWidget {
//   final _ummah;
//   const TheProphet(this._ummah);
//   @override
//   State<TheProphet> createState() => _TheProphetState();
// }
//
// class _TheProphetState extends State<TheProphet> {
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
//   void share(BuildContext context) {
//     String message = 'Check out this useful content!';
//     RenderBox? box = context.findRenderObject() as RenderBox;
//
//     Share.share(message, subject: 'Desription',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   }
//
//   bool isReadmore= false;
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
//                 onPressed: () => share(context,),
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
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(children: <Widget>[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(widget._ummah['info-title'],
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   const Divider(
//                     color: Colors.black,
//                     height: 25,
//                     thickness: 1,
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Description",
//                         style: const TextStyle(
//                           fontSize: 20.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(widget._ummah['info-desc'],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 15.0,
//                           fontFamily: 'PoppinsRegular',
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(height: 10,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-title-lesson'][0],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-lesson'][0],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(height: 10,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][0],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][0],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][0],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][0],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][0],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//                   //todo: second surah here
//                   SizedBox(height: 10,),
//
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-title-lesson'][1],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-lesson'][1],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   SizedBox(height: 10,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][1],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][1],textAlign:TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][1],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][1],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][1],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   //todo: third surah here
//                   SizedBox(height: 10,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-title-lesson'][2],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-lesson'][2],textAlign: TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsMedium',
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   SizedBox(height: 10,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][2],textAlign:TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][2],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][2],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][2],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][2],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   //todo: fourth surah here
//                   SizedBox(height: 10,),
//
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][3],textAlign:TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][3],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][3],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][3],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][3],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   //todo: fifth surah here
//                   SizedBox(height: 10,),
//
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][4],textAlign:TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][4],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][4],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][4],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][4],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   //todo: sixth surah here
//                   SizedBox(height: 10,),
//
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][5],textAlign:TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][5],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][5],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][5],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-mean'][5],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsMedium',
//                           fontStyle: FontStyle.normal,
//                           color: Colors.black,
//                         )),
//                   ),
//
//                   //todo: seventh surah here
//                   SizedBox(height: 10,),
//
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah'][6],textAlign:TextAlign.justify,
//                         style: const TextStyle(
//                           fontSize: 18.0,
//                           fontFamily: 'PoppinsThin',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-surah-name'][6],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['trans-text'][6],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(widget._ummah['info-translation'][6],textAlign: TextAlign.justify,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontFamily: 'PoppinsLight',
//                           fontStyle: FontStyle.italic,
//                           color: Colors.black,
//                         )),
//                   ),
//
//
//
//                   SizedBox(height: 10,),
//
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: RaisedButton(
//                           child: Text('Description',style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                             fontFamily: 'PoppinsMedium',
//                           ),),
//                           onPressed: () {
//                           },
//                           color: Colors.black,
//                         ),
//                       ),
//                       Expanded(
//                         child: RaisedButton(
//                           child: Text('Video',style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16.0,
//                             fontFamily: 'PoppinsMedium',
//                           ),),
//                           onPressed: () async{
//                             final ummah = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
//                             ummah.get().then((QuerySnapshot snapshot) {
//                               snapshot.docs.forEach((DocumentSnapshot doc) {
//                                 final _ummah = doc;
//                                 setState(() {
//                                   if (doc["info-title"] == widget._ummah["info-title"]) {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 VideoUmmah(_ummah)));
//                                   }
//                                 });
//                               });
//                             });
//                           },
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   )
//
//                 ]),
//               ),
//             ],
//           ),
//         ));
//   }
// }
//
// // Create a expandable/ collapsable text widget
// class TextWrapper extends StatefulWidget {
//   const TextWrapper({Key? key, required this.text}) : super(key: key);
//
//   final String text;
//
//   @override
//   _TextWrapperState createState() => _TextWrapperState();
// }
//
// class _TextWrapperState extends State<TextWrapper>
//     with TickerProviderStateMixin {
//   bool isExpanded = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           child: ConstrainedBox(
//               constraints: isExpanded
//                   ? const BoxConstraints()
//                   : const BoxConstraints(maxHeight: 70),
//               child: Text(
//                 widget.text,
//                 style: const TextStyle(fontSize: 16),
//                 softWrap: true,
//                 overflow: TextOverflow.fade,
//               ))),
//       isExpanded
//           ? Align(
//         alignment: Alignment.centerRight,
//         child: OutlinedButton.icon(
//             icon: const Icon(Icons.arrow_upward),
//             label: const Text('Read less'),
//             onPressed: () => setState(() => isExpanded = false)),
//       )
//           : Align(
//         alignment: Alignment.centerRight,
//         child: TextButton.icon(
//             icon: const Icon(Icons.arrow_downward),
//             label: const Text('Read more'),
//             onPressed: () => setState(() => isExpanded = true)),
//       )
//     ]);
//   }
// }
//
// class ExpandableText extends StatefulWidget {
//   ExpandableText(this.text);
//
//   final String text;
//   bool isExpanded = false;
//
//   @override
//   _ExpandableTextState createState() => new _ExpandableTextState();
// }
//
// class _ExpandableTextState extends State<ExpandableText> {
//   @override
//   Widget build(BuildContext context) {
//     return new Column(children: <Widget>[
//       new ConstrainedBox(
//           constraints: widget.isExpanded
//               ? new BoxConstraints()
//               : new BoxConstraints(maxHeight: 50.0),
//           child: new Text(
//             widget.text,
//             softWrap: true,
//             overflow: TextOverflow.fade,
//           )),
//       widget.isExpanded
//           ? new Container()
//           : new FlatButton(
//           child:  Align
//             (alignment: Alignment.centerRight,
//               child: Text('Read More...')),
//           onPressed: () => setState(() => widget.isExpanded = true))
//     ]);
//   }
// }
//
//
//
//
// int hexColor(String color) {
//   //adding prefix
//   String newColor = '0xff' + color;
//   //removing # sign
//   newColor = newColor.replaceAll('#', '');
//   //converting it to the integer
//   int finalColor = int.parse(newColor);
//   return finalColor;
// }