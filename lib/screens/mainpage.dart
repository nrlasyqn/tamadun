import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamadun/screens/the_existence.dart';
import 'package:tamadun/screens/living_things.dart';
import 'package:flutter/material.dart';
import 'beforetheexistence.dart';
import 'empierofislam.dart';
import 'homosapiens.dart';

class MainPage extends StatefulWidget {
  //MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('mainPage')
            .doc('allTopic')
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          return snapshot.hasData
              ? SingleChildScrollView(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 25, bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Tamadun',
                                style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  fontSize: 28,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(36, 6, 36, 6),
                            child: Material(
                              color: Colors.black54,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(18),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              universe()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image:
                                      //AssetImage(
                                      //  'images/beforeuniverse.jpeg'),
                                      NetworkImage("${snapshot.data!['image'][0]}"),
                                      height: 115,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      //'Before The Creation of Universe',
                                        "${snapshot.data!['title'][0]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    Text("${snapshot.data!['secTitle'][0]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(36, 6, 36, 6),
                            child: Material(
                              color: Colors.black54,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(18),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              the_existence()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image: NetworkImage("${snapshot.data!['image'][1]}"),
                                      height: 115,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                        "${snapshot.data!['title'][1]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                        "${snapshot.data!['secTitle'][1]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(36, 6, 36, 6),
                            child: Material(
                              color: Colors.black54,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(18),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              living_things()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image: NetworkImage("${snapshot.data!['image'][2]}"),
                                      height: 115,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      //'Living Things Before Creation of Man',
                                        "${snapshot.data!['title'][2]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      //'Living Things Before Creation of Man',
                                        "${snapshot.data!['secTitle'][2]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(36, 6, 36, 6),
                            child: Material(
                              color: Colors.black54,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(18),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              homosapiens()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image: NetworkImage("${snapshot.data!['image'][3]}"),
                                      height: 115,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      //'The First Man on Earth',
                                        "${snapshot.data!['title'][3]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      Center(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(36, 6, 36, 6),
                            child: Material(
                              color: Colors.black54,
                              elevation: 8,
                              borderRadius: BorderRadius.circular(18),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              empierofislam()));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Ink.image(
                                      image: NetworkImage("${snapshot.data!['image'][4]}"),
                                      height: 115,
                                      width: 330,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      //'The Islamic Empier',
                                        "${snapshot.data!['title'][4]}",
                                        style: TextStyle(
                                          fontFamily: 'PoppinsSemiBold',
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ])),
          )
              : Container();
        },
      ),
    );
  }
}
