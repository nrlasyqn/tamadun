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
    }).then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
                'Added to Favourite !'))));
  }

  void share(BuildContext context) {
    String message = 'Check out this useful content!';
    RenderBox? box = context.findRenderObject() as RenderBox;

    Share.share(message, subject: 'Desription',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget._theExist['info-title'],
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
                    isEqualTo: widget._theExist['info-title'])
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Text("");
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () =>
                      snapshot.data.docs.length == 0
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
                child: Image.network(widget._theExist['info-img'][0]),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-title'],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-sub'],
                        style: TextStyle(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Big Bang",
                        style: const TextStyle(

                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget._theExist['info-desc'][0],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'PoppinsLight',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //todo: info-surah(surah al anbiya':30)
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][0],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][0],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][0],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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

                  //todo: TAFSEER FOR (surah an-ANBIYA':30)
                  ExpansionTile(

                    title: Text(widget._theExist['tafsir-text'][0],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),

                    // Contents
                    children: [
                      ListTile(

                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-0'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][1],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-0'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-0'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][3],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-0'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  //todo: info-surah(surah hud:7)
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][1],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][1],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][1],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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
                  //todo: TAFSEER FOR (surah HUD:7)
                  ExpansionTile(
                    title: Text(widget._theExist['tafsir-text'][1],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                    // Contents
                    children: [
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-1'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][4],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-1'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-1'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][5],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-1'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Creation Of Sky And Earth",
                        style: const TextStyle(

                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  //todo: info-surah-three(surah al-anbiya':33)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Sky:",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][2],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][2],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][2],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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
                  //todo: TAFSEER FOR (surah an-ANBIYA':33)
                  ExpansionTile(
                    title: Text(widget._theExist['tafsir-text'][2],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                    // Contents
                    children: [
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][6],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-2'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][1],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-2'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-2'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-2'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //todo: info-surah-three(surah yaasin:38)
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][3],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][3],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][3],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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
                  //todo: TAFSEER FOR (surah YAASIN:38)
                  ExpansionTile(
                    title: Text(widget._theExist['tafsir-text'][3],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                    // Contents
                    children: [
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][1],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-3'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-3'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][6],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-3'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-3'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 10,
                  ),


                  //todo: info-surah-two(surah zukhruf:10)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Earth:",
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][4],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][4],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][4],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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
                  //todo: TAFSEER FOR (surah ZUKHRUF:10)
                  ExpansionTile(
                    title: Text(widget._theExist['tafsir-text'][4],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                    // Contents
                    children: [
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-4'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][1],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-4'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][5],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-4'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-4'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //todo: info-surah-one(surah an-naziat:26)
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah'][5],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(widget._theExist['info-surah_name'][5],
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                  ),
                  Align(
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
                    child: Text(widget._theExist['info-translation'][5],
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'PoppinsMedium',
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
                  //todo: TAFSEER FOR (surah an-NAZIAT:26)
                  ExpansionTile(
                    title: Text(widget._theExist['tafsir-text'][5],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsMedium',
                          color: Colors.black,
                        )),
                    // Contents
                    children: [
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][1],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-5'][0],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][0],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-5'][1],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][5],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-5'][2],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                      ListTile(
                        title: Text(widget._theExist['info-tafsir-name'][2],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'PoppinsMedium',
                              color: Colors.black,
                            )),
                        subtitle: Text(
                            widget._theExist['info-tafsir-surah-5'][3],
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'PoppinsLight',
                              color: Colors.black,
                            )),),
                    ],
                  ),
                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  SizedBox(
                    height: 10,
                  ),

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
                    height: 15,
                  ),
                  //todo: insert video here
                  Container(
                    height: 300,
                    child: VideoPlayer(
                      videoData: widget._theExist['info-video'][0],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // MaterialButton(
                      //   onPressed: () {
                      //     //todo:Before The Existence
                      //     final before = FirebaseFirestore.instance
                      //         .collection('the-existence-of-universe');
                      //     before.get().then((QuerySnapshot snapshot) {
                      //       snapshot.docs.forEach((DocumentSnapshot doc) {
                      //         final _theExist = doc;
                      //         setState(() {
                      //           if (doc["info-title"] ==
                      //               widget._theExist["info-title"]) {
                      //             print(widget._theExist["info-video"][0]);
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         VideotheExistence(_theExist)));
                      //           }
                      //         });
                      //       });
                      //     });
                      //   },
                      //   child: Text("Video"),
                      //   color: Colors.yellow,
                      // ),
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
        ));
  }
}