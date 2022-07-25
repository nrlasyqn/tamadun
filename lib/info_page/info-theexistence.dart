import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tamadun/info_page/video.dart';

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
                content: Text('Added to Favourite !'))));
  }

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message,
        subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
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
              IconButton(
                icon: Icon(Icons.share_outlined),
                color: Colors.black,
                onPressed: () => share(
                  context,
                ),
              ),
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.network(widget._theExist['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(children: <Widget>[
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
                  child: Text(widget._theExist['info-desc'],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsRegular',
                        color: Colors.black,
                      )),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("   Big Bang",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsRegular',
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][0],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][0],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
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
                  child: Text(widget._theExist['info-translation'][0],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][1],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][1],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
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
                  child: Text(widget._theExist['info-translation'][1],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("   Sky",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsRegular',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][2],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][2],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Translation:  ",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-translation'][2],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][3],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][3],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
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
                  child: Text(widget._theExist['info-translation'][3],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("   Earth",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsRegular',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][4],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][4],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
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
                  child: Text(widget._theExist['info-translation'][4],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah'][5],
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsThin',
                        color: Colors.black,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(widget._theExist['info-surah_name'][5],
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'PoppinsLight',
                        color: Colors.black,
                      )),
                ),
                Align(
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
                  child: Text(widget._theExist['info-translation'][5],
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

                //todo: insert video here
                Container(
                  height: 300,
                  child: VideoPlayer(
                    videoData: widget._theExist['info-video'],
                  ),
                ),

                SizedBox(
                  height: 10,
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
            ],
          ),
        ));
  }
}
