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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(150,202,220, 1.0),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Tamadun',
            style: TextStyle(
              fontFamily: 'MontserratBold',
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              /* Navigator.push(
                context, MaterialPageRoute(builder: (context) => ummah()));*/
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => ummah()));
              });
            },
          ),
        ),
        body:
        //todo:mobileview
        screenWidth < 576
            ? StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ummah')
              .doc('the-prophets')
              .collection('prophets-button')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState ==
                ConnectionState.waiting)
                ? Center(
              child: CircularProgressIndicator(
                color: Color(hexColor('#25346a')),
              ),
            )
                : ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index].data()
                  as Map<String, dynamic>;

                  if (name.isEmpty) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/8.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                            top: 30.0,
                            bottom: 0.0),
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0)),
                          padding: const EdgeInsets.only(
                              top: 7.0, bottom: 7.0, right: 0.0, left: 00.0),
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


                          textColor: Color(0xFF292929),
                          color: Color(
                            hexColor('c0dfea'),
                          ),

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              children: [

                                Expanded(child: Row(children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(data['info-img'][0]),
                                  ),
                                  SizedBox(width: 10,),

                                  Text( data['info-title'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'PoppinsMedium',
                                      fontSize: 16,),),
                                ]),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                });
          },
        )
        //todo:tab
            : screenWidth < 992
            ? StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('ummah')
              .doc('the-prophets')
              .collection('prophets-button')
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState ==
                ConnectionState.waiting)
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index]
                      .data() as Map<String, dynamic>;

                  if (name.isEmpty) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/8.0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0,
                            right: 50.0,
                            top: 30.0,
                            bottom: 0.0),
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0)),
                          padding: const EdgeInsets.only(
                              top: 7.0, bottom: 7.0, right: 0.0, left: 00.0),
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


                          textColor: Color(0xFF292929),
                          color: Color(
                            hexColor('c0dfea'),
                          ),

                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              children: [

                                Expanded(child: Row(children:[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(data['info-img'][0]),
                                  ),
                                  SizedBox(width: 10,),

                                  Text( data['info-title'],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontFamily: 'PoppinsMedium',
                                      fontSize: 16,),),
                                ]),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                });
          },
        )
            : null
    );
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