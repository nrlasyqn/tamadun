
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/homosapiens.dart';
import 'package:tamadun/screens/monotheistic_empire.dart';
import 'package:tamadun/timeline/timeline_theexistence.dart';
import 'package:tamadun/timeline/timeline_ummah.dart';
import '../screens/beforetheexistence.dart';
import 'home_page.dart';

class ummah extends StatefulWidget {
  @override
  _ummahClassState createState() => _ummahClassState();
}

class _ummahClassState extends State<ummah> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(201, 167, 194, 1.0),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Ummah Empire',
          textAlign: TextAlign.left,
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
            /*Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));*/
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          },
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('mainTopic')
            .doc('ummah')
            .get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          return snapshot.hasData
          //todo:mobile view
              ? SingleChildScrollView(
              child: screenWidth < 576
                  ?  Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                      height: size.height,
                      width: size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(201, 167, 194, 1.0),
                                Color.fromRGBO(201, 167, 194, 1.0),
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
                          height: 100.0,
                        ),
                        Container(
                          width: 300,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TimelineUmmah()));
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
                                    "${snapshot.data!['topic-1']}",
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
                                    builder: (context) => homosapiens()));
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
                                    builder: (context) => monotheistic_empire()));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
              //todo:android tablet view
                  :SingleChildScrollView(
                  child: screenWidth < 992
                      ?  Stack(
                    children: [
                      ClipPath(
                        clipper: DrawCliptablet(),
                        child: Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(201, 167, 194, 1.0),
                                    Color.fromRGBO(201, 167, 194, 1.0),
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
                            Padding(
                              padding: const EdgeInsets.only(top:35.0),
                              child: CircleAvatar(
                                backgroundImage:
                                NetworkImage("${snapshot.data!['image']}"),
                                minRadius: 70,
                                maxRadius: 120,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "${snapshot.data!['title']}",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'PoppinsSemiBold',
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 170.0,
                            ),
                            Container(
                              width: 400,
                              child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TimelineUmmah()));
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
                                          maxWidth: 500.0, minHeight: 70.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${snapshot.data!['topic-1']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20.0,
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
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homosapiens()));
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
                              padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => monotheistic_empire()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )

                  //todo:android ipad view
                      :SingleChildScrollView(
                      child: screenWidth < 2800
                          ?  Stack(
                        children: [
                          ClipPath(
                            clipper: DrawClipipad(),
                            child: Container(
                              height: size.height,
                              width: size.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(201, 167, 194, 1.0),
                                        Color.fromRGBO(201, 167, 194, 1.0),
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
                                Padding(
                                  padding: const EdgeInsets.only(top:50.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                    NetworkImage("${snapshot.data!['image']}"),
                                    minRadius: 70,
                                    maxRadius: 150,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "${snapshot.data!['title']}",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontFamily: 'PoppinsSemiBold',
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 220.0,
                                ),
                                Container(
                                  width: 500,
                                  child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TimelineUmmah()));
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
                                              maxWidth: 600.0, minHeight: 90.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${snapshot.data!['topic-1']}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 23.0,
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
                                  padding: EdgeInsets.fromLTRB(20, 70, 20, 70),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => homosapiens()));
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
                                  padding: EdgeInsets.fromLTRB(20, 70, 20, 70),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => monotheistic_empire()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ):null
                    // "${snapshot.data!['title']}",
                  )))
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
        Rect.fromCircle(center: Offset(size.width * 0.5, -80), radius: 370));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
class DrawCliptablet extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, -190), radius: 670));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
class DrawClipipad extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, -280), radius: 870));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}