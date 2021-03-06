import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/home_page.dart';
import 'package:tamadun/screens/the_ummah.dart';
import 'package:tamadun/timeline/timeline_empier.dart';
import 'package:tamadun/timeline/timeline_monathestic.dart';

import '../screens/beforetheexistence.dart';
import '../screens/empierofislam.dart';

class monotheistic_empire extends StatefulWidget {
  @override
  _monotheistic_empireClassState createState() => _monotheistic_empireClassState();
}

class _monotheistic_empireClassState extends State<monotheistic_empire> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(167, 201, 201, 1.0),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Tamadun',
          style: TextStyle(
            fontFamily: 'MontserratBold',
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('mainTopic')
            .doc('monotheistic-empire')
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          return snapshot.hasData
              ? SingleChildScrollView(
            child: Stack(
              children: [
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(167, 201, 201, 1.0),
                              Color.fromRGBO(167, 201, 201, 1.0),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft)),
                  ),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: double.infinity,
                  height: 100.0,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage("${snapshot.data!['image']}"),
                        minRadius: 70,
                        maxRadius: 80,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "${snapshot.data!['title']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'PoppinsSemiBold',
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimelineMonathestic()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!['topic'][0]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimelineMonathestic()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!['topic'][1]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimelineMonathestic()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!['topic'][2]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimelineMonathestic()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!['topic'][3]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 300,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TimelineMonathestic()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2)),
                            elevation: 0.0,
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 300.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "${snapshot.data!['topic'][4]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                      ),

                    ],
                  ),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ummah()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.width,
                  width: size.width,
                  margin: EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => empierofislam()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // "${snapshot.data!['title']}",
          )
              : Container();
        },
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, -90), radius: 360));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
