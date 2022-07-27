import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/info_page/info_ummah.dart';
//import 'package:tamadun/info_page/info-prophets.dart';
import 'package:tamadun/screens/homosapiens.dart';
import 'package:tamadun/screens/monotheistic_empire.dart';
import 'package:tamadun/screens/the_ummah.dart';
import 'package:tamadun/timeline/timeline_theexistence.dart';
import 'package:tamadun/timeline/timeline_ummah.dart';
import '../screens/beforetheexistence.dart';

class j extends StatefulWidget {
  @override
  _jState createState() => _jState();
}

class _jState extends State<j> {
  @override
  String name = "";
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(201, 167, 194, 1.0),
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
                context, MaterialPageRoute(builder: (context) => ummah()));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection('prophets-button').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;

                if (name.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 30.0, bottom: 0.0),
                    child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding: EdgeInsets.only(
                          top: 7.0, bottom: 7.0, right: 0.0, left: 0.0),
                      onPressed: () async {
                        final before = FirebaseFirestore.instance
                            .collection('ummah').doc('the-prophets').collection("prophets-button");
                        before.get().then((QuerySnapshot snapshot) {
                          snapshot.docs.forEach((DocumentSnapshot doc) {
                            final _ummah = doc;
                            setState(() {
                              if (doc["info-title"] ==
                                  data["info-title"]) {
                                print(doc["info-title"]);
                                print(doc.id);
                                print(_ummah.id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TheProphet(
                                                _ummah)));
                              }
                            });
                          });
                        });
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(data['info-img'][0]),

                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              data['info-title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                              //textAlign: TextAlign.center,

                            ),

                          ),
                          Padding(padding:const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.black)),

                          ),





                        ],

                      ),

                      textColor: Color(0xFF292929),
                      color: Color(
                        hexColor('e6b1d5'),
                      ),


                    ),

                  );

                }
                return Container();
              });
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

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}





