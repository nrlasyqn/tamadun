import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamadun/screens/home_page.dart';

import '../info_page/info-theexistence.dart';
import '../info_page/info_beforebigbang.dart';
import '../info_page/info_empier.dart';
import '../info_page/info_islamic.dart';
import '../info_page/info_living_things.dart';
import '../info_page/info_ummah.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String inputText = "";

  List<Map<String, dynamic>> data = [];
  addData() async {
    for (var element in data) {}
    print('all data added');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Search',
            style: TextStyle(
              fontFamily: 'MontserratBold',
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('tamadun-info')
                          .snapshots(),
                      builder: (context, snapshots) {
                        return (snapshots.connectionState == ConnectionState.waiting)
                            ? Center(
                          child: CircularProgressIndicator(),
                        )
                            : ListView.builder(
                            itemCount: snapshots.data == null ? 0 : snapshots.data!.docs.length,
                            itemBuilder: (_, index) {
                              DocumentSnapshot data = snapshots.data!.docs[index];


                              if (inputText.isEmpty) {

                                return Card(
                                    elevation: 0.74,
                                    child: SingleChildScrollView(
                                        child:ListTile(
                                            title: Text(
                                              data['info-title'],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsMedium',
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),

                                            ),
                                            subtitle: Text(
                                              data['info-sub'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsRegular',
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage:
                                              //note : info-img in firebase is array, must add [0] everytime when u want to fetch the img
                                              NetworkImage(data['info-img'][0]),
                                              radius:24.3,
                                            ),
                                            onTap: () async {
                                              //doc is fetch from specific firebase based on the title
                                              //_documentSnapshot is from tamadun-users-favorite

                                              //todo:Before The Existence
                                              final before = FirebaseFirestore
                                                  .instance.collection(
                                                  'before-the-existence');
                                              before.get().then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs.forEach((
                                                    DocumentSnapshot docs) {
                                                  final _beforeExist = docs;
                                                  setState(() {
                                                    //doc from before the existence
                                                    //data = tamadun-info
                                                    if (data['info-title'] ==
                                                        docs ['info-title']) {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist)));
                                                    }
                                                  });
                                                });});


                                              //todo:The Existence
                                              final exist = FirebaseFirestore
                                                  .instance.collection(
                                                  'the-existence-of-universe');
                                              exist.get().then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs.forEach((
                                                    DocumentSnapshot docs) {
                                                  final _theExist = docs;
                                                  setState(() {
                                                    if (data["info-title"] ==
                                                        docs["info-title"]) {
                                                      print(
                                                          data["info-title"]);
                                                      print(docs.id);
                                                      print(
                                                          docs["info-title"]);
                                                      print(docs.id);
                                                      print(_theExist.id);
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  InfoTheExistence(
                                                                      _theExist)));
                                                    }
                                                  });});});


                                              //todo: Homosapiens
                                              final homosapiens = FirebaseFirestore
                                                  .instance.collection(
                                                  'first-man-on-earth');
                                              homosapiens.get().then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs.forEach((
                                                    DocumentSnapshot docs) {
                                                  final _homosapiens = docs;
                                                  setState(() {
                                                    if (data["info-title"] ==
                                                        docs["info-title"]) {
                                                      print(
                                                          data["info-title"]);
                                                      print(docs.id);
                                                      print(
                                                          docs["info-title"]);
                                                      print(docs.id);
                                                      print(_homosapiens
                                                          .id);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  InfoHomosapiens(
                                                                      _homosapiens)));
                                                    }
                                                  });});});


                                              //todo: living_things
                                              final living_things = FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                  'living-things');
                                              living_things.get()
                                                  .then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs
                                                    .forEach((
                                                    DocumentSnapshot docs) {
                                                  final _livingthings = docs;
                                                  setState(() {
                                                    if (data["info-title"] ==
                                                        docs["info-title"]) {
                                                      print(
                                                          data["info-title"]);
                                                      print(docs.id);
                                                      print(
                                                          docs["info-title"]);
                                                      print(docs.id);
                                                      print(
                                                          _livingthings
                                                              .id);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  InfoLivingThings(
                                                                      _livingthings)));
                                                    }
                                                  });});});


                                              //todo: Glorious of Empire Islam
                                              final glorious = FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                  'the-islamic-empire');
                                              glorious.get()
                                                  .then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs
                                                    .forEach((
                                                    DocumentSnapshot docs) {
                                                  final _empire = docs;
                                                  setState(() {
                                                    if (data["info-title"] ==
                                                        docs["info-title"]) {
                                                      print(
                                                          data["info-title"]);
                                                      print(
                                                          docs.id);
                                                      print(
                                                          docs["info-title"]);
                                                      print(
                                                          docs .id);
                                                      print(
                                                          _empire
                                                              .id);
                                                      Navigator
                                                          .push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  InfoEmpire(
                                                                      _empire)));
                                                    }
                                                  });
                                                });
                                              });

                                              //todo:Prophets / the Ummah
                                              final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
                                              prophet.get()
                                                  .then((
                                                  QuerySnapshot snapshots) {
                                                snapshots.docs
                                                    .forEach((
                                                    DocumentSnapshot docs) {
                                                  final _ummah = docs;
                                                  setState(() {
                                                    if (data["info-title"] ==
                                                        docs["info-title"]) {
                                                      print(
                                                          data["info-title"]);
                                                      print(
                                                          docs.id);
                                                      print(
                                                          docs["info-title"]);
                                                      print(
                                                          docs .id);
                                                      print(
                                                          _ummah
                                                              .id);
                                                      Navigator
                                                          .push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  });
                                                });
                                              });


                                            })));
                              }

                              //todo: when click on search user will redirect to info page
                              if (data['info-title']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(inputText.toLowerCase())) {
                                return GestureDetector(
                                  onTap: () async {
                                    //doc is fetch from specific firebase based on the title
                                    //_documentSnapshot is from tamadun-users-favorite

                                    //todo:Before The Existence
                                    final before = FirebaseFirestore
                                        .instance.collection(
                                        'before-the-existence');
                                    before.get().then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs.forEach((
                                          DocumentSnapshot docs) {
                                        final _beforeExist = docs;
                                        setState(() {
                                          //doc from before the existence
                                          //data = tamadun-info
                                          if (data['info-title'] ==
                                              docs ['info-title']) {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        InfoBeforeExistence(
                                                            _beforeExist)));
                                          }
                                        });
                                      });});


                                    //todo:The Existence
                                    final exist = FirebaseFirestore
                                        .instance.collection(
                                        'the-existence-of-universe');
                                    exist.get().then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs.forEach((
                                          DocumentSnapshot docs) {
                                        final _theExist = docs;
                                        setState(() {
                                          if (data["info-title"] ==
                                              docs["info-title"]) {
                                            print(
                                                data["info-title"]);
                                            print(docs.id);
                                            print(
                                                docs["info-title"]);
                                            print(docs.id);
                                            print(_theExist.id);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        InfoTheExistence(
                                                            _theExist)));
                                          }
                                        });});});


                                    //todo: Homosapiens
                                    final homosapiens = FirebaseFirestore
                                        .instance.collection(
                                        'first-man-on-earth');
                                    homosapiens.get().then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs.forEach((
                                          DocumentSnapshot docs) {
                                        final _homosapiens = docs;
                                        setState(() {
                                          if (data["info-title"] ==
                                              docs["info-title"]) {
                                            print(
                                                data["info-title"]);
                                            print(docs.id);
                                            print(
                                                docs["info-title"]);
                                            print(docs.id);
                                            print(_homosapiens
                                                .id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        InfoHomosapiens(
                                                            _homosapiens)));
                                          }
                                        });});});


                                    //todo: living_things
                                    final living_things = FirebaseFirestore
                                        .instance
                                        .collection(
                                        'living-things');
                                    living_things.get()
                                        .then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs
                                          .forEach((
                                          DocumentSnapshot docs) {
                                        final _livingthings = docs;
                                        setState(() {
                                          if (data["info-title"] ==
                                              docs["info-title"]) {
                                            print(
                                                data["info-title"]);
                                            print(docs.id);
                                            print(
                                                docs["info-title"]);
                                            print(docs.id);
                                            print(
                                                _livingthings
                                                    .id);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        InfoLivingThings(
                                                            _livingthings)));
                                          }
                                        });});});



                                    //todo: Glorious of Empire Islam
                                    final glorious = FirebaseFirestore
                                        .instance
                                        .collection(
                                        'the-islamic-empire');
                                    glorious.get()
                                        .then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs
                                          .forEach((
                                          DocumentSnapshot docs) {
                                        final _empire = docs;
                                        setState(() {
                                          if (data["info-title"] ==
                                              docs["info-title"]) {
                                            print(
                                                data["info-title"]);
                                            print(
                                                docs.id);
                                            print(
                                                docs["info-title"]);
                                            print(
                                                docs .id);
                                            print(
                                                _empire
                                                    .id);
                                            Navigator
                                                .push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        InfoEmpire(
                                                            _empire)));
                                          }
                                        });
                                      });
                                    });

                                    //todo:Prophets / the Ummah
                                    final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
                                    prophet.get()
                                        .then((
                                        QuerySnapshot snapshots) {
                                      snapshots.docs
                                          .forEach((
                                          DocumentSnapshot docs) {
                                        final _ummah = docs;
                                        setState(() {
                                          if (data["info-title"] ==
                                              docs["info-title"]) {
                                            print(
                                                data["info-title"]);
                                            print(
                                                docs.id);
                                            print(
                                                docs["info-title"]);
                                            print(
                                                docs .id);
                                            print(
                                                _ummah
                                                    .id);
                                            Navigator
                                                .push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (
                                                        context) =>
                                                        TheProphet(
                                                            _ummah)));
                                          }
                                        });
                                      });
                                    });


                                  },
                                    child: Card(
                                      elevation: 0.74,
                                      child: SingleChildScrollView(
                                          child:ListTile(
                                            title: Text(
                                              data['info-title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsMedium',
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),

                                            ),
                                            subtitle: Text(
                                              data['info-sub'],
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsRegular',
                                                fontSize: 11,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage:
                                              //note : info-img in firebase is array, must add [0] everytime when u want to fetch the img
                                              NetworkImage(data['info-img'][0]),
                                              radius:24.3,
                                            ),
                                          )),
                                    ));
                              }
                              return Container();
                            });
                      },
                    )))
          ],
        ));
  }
}