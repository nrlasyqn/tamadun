import 'package:tamadun/screens/homosapiens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/beforetheexistence.dart';
import '../screens/empierofislam.dart';
import '../screens/the_existence.dart';

//todo: fetch info -> info tamadun
class FetchInfo extends StatefulWidget {
  const FetchInfo({Key? key}) : super(key: key);

  @override
  State<FetchInfo> createState() => _FetchInfoState();
}

class _FetchInfoState extends State<FetchInfo> {
  List _tamadunInfo = [];
  var _firestoreInstance = FirebaseFirestore.instance;


  fetchInfo() async {
    QuerySnapshot qn =
    await _firestoreInstance.collection("mainTopic").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _tamadunInfo.add({
          "title": qn.docs[i]["title"],
          "image": qn.docs[i]["image"],
          "topic-1": qn.docs[i]["topic-1"],
          "topic-2": qn.docs[i]["topic-2"],
          "topic-3": qn.docs[i]["topic-3"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchInfo();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Fetch Info",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      homosapiens(),
                ));
            //Navigator.of(context)
            //    .push(MaterialPageRoute(builder: (context) => Welcome()));
          },
        ),
      ),
      body: ListView.builder(
          itemCount: _tamadunInfo.length,
          itemBuilder: (_,index){
            return SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        height: size.height,
                        width: size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color.fromRGBO(167, 201, 177, 1.0),Color.fromRGBO(167, 201, 177, 1.0),],
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
                            backgroundImage: AssetImage('images/zaman.jpeg'),
                            minRadius: 70,
                            maxRadius: 80,
                          ),
                          SizedBox(
                            height: 20.0,

                          ),
                          Text(
                            "The Islamic",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'PoppinsSemiBold',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Empier",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'PoppinsSemiBold',
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Container(
                            width: 300,
                            child: RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    side:BorderSide(color:Colors.black, width: 2)
                                ),
                                elevation: 0.0,
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text( "${_tamadunInfo[index]["info-title"]}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'PoppinsMedium',
                                        color: Colors.black,),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            child: RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    side:BorderSide(color:Colors.black, width: 2)
                                ),
                                elevation: 0.0,
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text("Prophethood of Prophet       Muhammad ﷺ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'PoppinsMedium',
                                        color: Colors.black,),
                                    ),
                                  ),
                                )
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: 300,
                            child: RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    side:BorderSide(color:Colors.black, width: 2)
                                ),
                                elevation: 0.0,
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text("Khulafa' al-Rashidin and the Era of Tabi' al-Tabi'in",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.0,
                                        fontFamily: 'PoppinsMedium',
                                        color: Colors.black,),
                                    ),
                                  ),
                                )
                            ),
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
                            icon: Icon(Icons.arrow_back_ios, size: 30,),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>homosapiens()));
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
                            icon: Icon(Icons.arrow_forward_ios, size: 30,),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>universe()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5,-90), radius: 360));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}