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
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(seconds: 1),
            content: Text('Added to Favourite!'))));
  }

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message,
        subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  bool isReadmore = false;
  bool _isloading = false;

  void initState() {
    _isloading = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            title: Text(
              widget._livingthings['info-title'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "MontserratBold",
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.black,
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                });
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
                icon: const Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(
                  context,
                ),
              ),
            ]),
        body: screenWidth < 576
            ? _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(
                    widget._livingthings['info-img'][0],),
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
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-sub'],
                        style: const TextStyle(
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['info-surah'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._livingthings['info-surah_name'][0],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['trans-text'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._livingthings['info-translation'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-desc'][1],
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
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
                          onPressed: () {
                            final living_things = FirebaseFirestore
                                .instance
                                .collection('living-things');
                            living_things
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _livingthings = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._livingthings[
                                      "info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoLivingThings(
                                                    _livingthings)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
                          child: const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        )
            : screenWidth < 992
            ? _isloading
            ? Center(
            child: CircularProgressIndicator(
              color: Color(
                hexColor('#25346a'),
              ),
            ))
            : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(
                    widget._livingthings['info-img'][0],),
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
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-sub'],
                        style: const TextStyle(
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

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
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
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['info-surah'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsThin',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._livingthings['info-surah_name'][0],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._livingthings['trans-text'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        widget._livingthings['info-translation'][0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsLight',
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._livingthings['info-desc'][1],
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsRegular',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: const Text(
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
                          onPressed: () {
                            final living_things = FirebaseFirestore
                                .instance
                                .collection('living-things');
                            living_things
                                .get()
                                .then((QuerySnapshot snapshot) {
                              snapshot.docs
                                  .forEach((DocumentSnapshot doc) {
                                final _livingthings = doc;
                                setState(() {
                                  if (doc["info-title"] ==
                                      widget._livingthings[
                                      "info-title"]) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoLivingThings(
                                                    _livingthings)));
                                  }
                                });
                              });
                            });
                          },
                          color: Colors.grey,
                          child: const Text(
                            'Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        )
            : null);
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
          child: const Align(
              alignment: Alignment.centerRight,
              child: Text('Read More...')),
          onPressed: () => setState(() => widget.isExpanded = true))
    ]);
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
