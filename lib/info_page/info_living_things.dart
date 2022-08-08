import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../info_video/info_video_livingthings.dart';
//import 'package:tamadun/timeline/timeline_living_things.dart';
//import '../timeline/timeline_beforebigbang.dart';

class InfoLivingThings extends StatefulWidget {
  final _livingthings;
  const InfoLivingThings(this._livingthings);
  @override
  State<InfoLivingThings> createState() => _InfoLivingThingsState();
}

class _InfoLivingThingsState extends State<InfoLivingThings> {
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
      "info-title": widget._livingthings["info-title"],
      "info-sub": widget._livingthings["info-sub"],
      "info-img": widget._livingthings["info-img"],
    }).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar( const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
            'Added to Favourite!'))));
  }

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  bool isReadmore= false;
  bool _isloading = false;

  void initState() {
    _isloading = true;
    Future.delayed(Duration(seconds: 5),(){
      setState((){
        _isloading=false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._livingthings['info-title'],
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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });},
            ),

            //todo: favorite button
            actions: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("tamadun-users-favorites")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("favorite-items")
                    .where("info-title",
                    isEqualTo: widget._livingthings['info-title'])
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
        body: _isloading ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ):SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._livingthings['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-sub'],
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
                    child: Image.network(widget._livingthings['info-img'][1]),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-desc'][0],
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
                    child: Text(widget._livingthings['info-surah'][0],textAlign:TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['info-surah_name'][0],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),

                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text("translation: ",
                  //       style: TextStyle(
                  //         fontSize: 16.0,
                  //         fontFamily: 'PoppinsMedium',
                  //         fontStyle: FontStyle.italic,
                  //         color: Colors.black,
                  //       )),
                  // ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['trans-text'][0],textAlign:TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['info-translation'][0],textAlign:TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-desc'][1],
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //   Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(widget._livingthings['info-desc_one'],
                  //        style: const TextStyle(
                  //           fontSize: 15.0,
                  //           fontFamily: 'PoppinsLight',
                  //           color: Colors.black,
                  //         )),
                  //   ),
                  SizedBox(
                    height: 10,
                  ),
                  //  Align(
                  //    alignment: Alignment.centerLeft,
                  //    child: Text(widget._livingthings['info-desc_one'],
                  //        style: const TextStyle(
                  //          fontSize: 15.0,
                  //          fontFamily: 'PoppinsLight',
                  //          color: Colors.black,
                  //        )),
                  //  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  //todo: Tafseer here
                  //  Align(
                  //    alignment: Alignment.centerLeft,
                  //    child: Text('Video',
                  //        style: TextStyle(
                  //          fontSize: 20.0,
                  //          fontFamily: 'PoppinsMedium',
                  //          color: Colors.black,
                  //        )),
                  //  ),
                  /*  Align(
                     alignment: Alignment.centerLeft,
                     child: Text("Tafseer",
                         style: const TextStyle(
                           fontSize: 20.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                SizedBox(
                  height: 13,
                ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir-name'][0],
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 6,
                   ),
                   TextWrapper(text: widget._livingthings['info-tafsir'][0]),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir-name'][1],
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   TextWrapper(text: widget._livingthings['info-tafsir'][1],),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir-name'][2],
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 6,
                   ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir'][2],textAlign:TextAlign.justify,
                         style: const TextStyle(
                           fontSize: 15.0,
                           fontFamily: 'PoppinsLight',
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir-name'][3],
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 6,
                   ),
                   SizedBox(width: 20,),
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Text(widget._livingthings['info-tafsir'][3],textAlign:TextAlign.justify,
                         style: const TextStyle(
                           fontSize: 15.0,
                           fontFamily: 'PoppinsLight',
                           color: Colors.black,
                         )),
                   ),*/

                  //todo: insert video here
                  //  Container(
                  //    height: 300,
                  //    child: VideoPlayer(
                  //      videoData: widget._livingthings['info-video'],
                  //    ),
                  //  ),

                  /* SizedBox(
                  height: 15,
                ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-surah'][1],
                         style: const TextStyle(
                           fontSize: 18.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-surah_name'][1],textAlign:TextAlign.justify,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['trans-text'][1],textAlign:TextAlign.center,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           fontStyle: FontStyle.italic,
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-translation'][1],textAlign:TextAlign.justify,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           fontStyle: FontStyle.italic,
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   //todo: third surah here
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-surah'][2],textAlign:TextAlign.justify,
                         style: const TextStyle(
                           fontSize: 18.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-surah_name'][2],
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['trans-text'][2],textAlign:TextAlign.center,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           fontStyle: FontStyle.italic,
                           color: Colors.black,
                         )),
                   ),
                   Align(
                     alignment: Alignment.center,
                     child: Text(widget._livingthings['info-translation'][2],textAlign:TextAlign.justify,
                         style: TextStyle(
                           fontSize: 16.0,
                           fontFamily: 'PoppinsMedium',
                           fontStyle: FontStyle.italic,
                           color: Colors.black,
                         )),
                   ),
                   SizedBox(
                     height: 10,
                   ),*/

                  //button video & description
                  /*   Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: <Widget>[
                       MaterialButton(
                         onPressed: () {
                           //todo:Before The Existence
                           final before = FirebaseFirestore.instance
                               .collection('living-things');
                           before.get().then((QuerySnapshot snapshot) {
                             snapshot.docs.forEach((DocumentSnapshot doc) {
                               final _livingthings = doc;
                               setState(() {
                                 if (doc["info-title"] == widget._livingthings["info-title"]) {
                                   print(widget._livingthings["info-video"]);

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
                         onPressed: () {},
                         child: Text("Description"),
                       ),
                     ],
                   ),*/
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
                            final living_things = FirebaseFirestore.instance
                                .collection('living-things');
                            living_things.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final _livingthings = doc;
                                setState(() {
                                  if (doc["info-title"] == widget._livingthings["info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoLivingThings(_livingthings)));
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
                  // )*/
                ]),
              ),
            ],
          ),
        )
    );
  }
}

// Create a expandable/ collapsable text widget
class TextWrapper extends StatefulWidget {
  const TextWrapper({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  _TextWrapperState createState() => _TextWrapperState();
}

class _TextWrapperState extends State<TextWrapper>
    with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
              constraints: isExpanded
                  ? const BoxConstraints()
                  : const BoxConstraints(maxHeight: 70),
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
                overflow: TextOverflow.fade,
              ))),
      isExpanded
          ? Align(
        alignment: Alignment.centerRight,
        child: OutlinedButton.icon(
            icon: const Icon(Icons.arrow_upward),
            label: const Text('Read less'),
            onPressed: () => setState(() => isExpanded = false)),
      )
          : Align(
        alignment: Alignment.centerRight,
        child: TextButton.icon(
            icon: const Icon(Icons.arrow_downward),
            label: const Text('Read more'),
            onPressed: () => setState(() => isExpanded = true)),
      )
    ]);
  }
}

//create expandable/collapsable text widget
class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new ConstrainedBox(
          constraints: widget.isExpanded
              ? new BoxConstraints()
              : new BoxConstraints(maxHeight: 50.0),
          child: new Text(
            style: const TextStyle(
              fontSize: 15.0,
              fontFamily: 'PoppinsLight',
              color: Colors.black,
            ),
            widget.text,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          )),
      widget.isExpanded
          ? new Container()
          : new MaterialButton(
          child:  Align
            (alignment: Alignment.centerRight,
              child: Text('Read More...')),
          onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}
