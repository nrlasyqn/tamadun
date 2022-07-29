import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamadun/info_page/info_monathestic.dart';
import 'package:tamadun/screens/home_page.dart';
import 'package:tamadun/screens/snackbar.dart';

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

                                              //todo:lock search topic before-existence [/]
                                              final userRole = FirebaseFirestore.instance
                                                  .collection("Users");
                                              final currUser =
                                                  FirebaseAuth.instance.currentUser!.email;
                                              final before = FirebaseFirestore.instance
                                                  .collection('before-the-existence');
                                              final exist = FirebaseFirestore.instance
                                                  .collection('the-existence-of-universe');
                                              final homosapiens = FirebaseFirestore.instance
                                                  .collection('first-man-on-earth');
                                              final living_things = FirebaseFirestore.instance
                                                  .collection('living-things');
                                              final glorious = FirebaseFirestore.instance
                                                  .collection('the-islamic-empire');
                                              final monathestic = FirebaseFirestore.instance
                                                  .collection('monathestic-empire');
                                              final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");

                                              //get user role
                                              //todo: prophet/ummah
                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  prophet.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _ummah = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "Prophet Adam a.s.)") {
                                                              if (docs['info-title'] == "Prophet Adam a.s.)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Prophet Idris a.s.") {
                                                              if (docs['info-title'] == "Prophet Idris a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Prophet Nuh a.s.") {
                                                              if (docs['info-title'] == "Prophet Nuh a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Prophet Hud a.s.") {
                                                              if (docs['info-title'] == "Prophet Hud a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Saleh a.s.") {
                                                              if (docs['info-title'] == "Prophet Saleh a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ibrahim a.s.") {
                                                              if (docs['info-title'] == "Prophet Ibrahim a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Luth a.s.") {
                                                              if (docs['info-title'] == "Prophet Luth a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ismail a.s.") {
                                                              if (docs['info-title'] == "Prophet Ismail a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ishaq a.s.") {
                                                              if (docs['info-title'] == "Prophet Ishaq a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yaqub a.s.") {
                                                              if (docs['info-title'] == "Prophet Yaqub a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yusuf a.s.") {
                                                              if (docs['info-title'] == "Prophet Yusuf a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ayyub a.s.") {
                                                              if (docs['info-title'] == "Prophet Ayyub a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Syuib a.s.") {
                                                              if (docs['info-title'] == "Prophet Syuib a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Musa a.s.") {
                                                              if (docs['info-title'] == "Prophet Musa a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Harun a.s.") {
                                                              if (docs['info-title'] == "Prophet Harun a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Zulkifli a.s.") {
                                                              if (docs['info-title'] == "Prophet Zulkifli a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Daud a.s.") {
                                                              if (docs['info-title'] == "Prophet Daud a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Sulaiman a.s.") {
                                                              if (docs['info-title'] == "Prophet Sulaiman a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ilyas a.s.") {
                                                              if (docs['info-title'] == "Prophet Ilyas a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ilyasa a.s.") {
                                                              if (docs['info-title'] == "Prophet Ilyasa a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yunus a.s.") {
                                                              if (docs['info-title'] == "Prophet Yunus a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Zakaria a.s.") {
                                                              if (docs['info-title'] == "Prophet Zakaria a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yahya a.s.") {
                                                              if (docs['info-title'] == "Prophet Yahya a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "Prophet Isa a.s.") {
                                                              if (docs['info-title'] == "Prophet Isa a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Muhammad s.a.w.") {
                                                              if (docs['info-title'] == "Prophet Muhammad s.a.w.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "Prophet Adam a.s.") {
                                                              if (docs['info-title'] == "Prophet Adam a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Idris a.s.") {
                                                              if (docs['info-title'] == "Prophet Idris a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Nuh a.s.") {
                                                              if (docs['info-title'] == "Prophet Nuh a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Hud a.s.") {
                                                              if (docs['info-title'] == "Prophet Hud a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Saleh a.s.") {
                                                              if (docs['info-title'] == "Prophet Saleh a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ibrahim a.s.") {
                                                              if (docs['info-title'] == "Prophet Ibrahim a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Luth a.s.") {
                                                              if (docs['info-title'] == "Prophet Luth a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ismail a.s.") {
                                                              if (docs['info-title'] == "Prophet Ismail a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ishaq a.s.") {
                                                              if (docs['info-title'] == "Prophet Ishaq a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yaqub a.s.") {
                                                              if (docs['info-title'] == "Prophet Yaqub a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yusuf a.s.") {
                                                              if (docs['info-title'] == "Prophet Yusuf a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ayyub a.s.") {
                                                              if (docs['info-title'] == "Prophet Ayyub a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Syuib a.s.") {
                                                              if (docs['info-title'] == "Prophet Syuib a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Musa a.s.") {
                                                              if (docs['info-title'] == "Prophet Musa a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Harun a.s.") {
                                                              if (docs['info-title'] == "Prophet Harun a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Zulkifli a.s.") {
                                                              if (docs['info-title'] == "Prophet Zulkifli a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Daud a.s.") {
                                                              if (docs['info-title'] == "Prophet Daud a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Sulaiman a.s.") {
                                                              if (docs['info-title'] == "Prophet Sulaiman a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ilyas a.s.") {
                                                              if (docs['info-title'] == "Prophet Ilyas a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Ilyasa a.s.") {
                                                              if (docs['info-title'] == "Prophet Ilyasa a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yunus a.s.") {
                                                              if (docs['info-title'] == "Prophet Yunus a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Zakaria a.s.") {
                                                              if (docs['info-title'] == "Prophet Zakaria a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Yahya a.s.") {
                                                              if (docs['info-title'] == "Prophet Yahya a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Isa a.s.") {
                                                              if (docs['info-title'] == "Prophet Isa a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Prophet Muhammad s.a.w.") {
                                                              if (docs['info-title'] == "Prophet Muhammad s.a.w.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            TheProphet(
                                                                                _ummah)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              //todo: monatheistic
                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  monathestic.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _monathestic = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                              if (docs['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                              if (docs['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                              if (docs['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Syariat Injil (Isa a.s)") {
                                                              if (docs['info-title'] == "Syariat Injil (Isa a.s)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                              if (docs['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                              if (docs['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoMonathestic(
                                                                                _monathestic)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                              if (docs['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoMonathestic(
                                                                                _monathestic)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                              if (docs['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoMonathestic(
                                                                                _monathestic)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Syariat Injil (Isa a.s)") {
                                                              if (docs['info-title'] == "Syariat Injil (Isa a.s)") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoMonathestic(
                                                                                _monathestic)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                              if (docs['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoMonathestic(
                                                                                _monathestic)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  glorious.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _glorious = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "The First City of Islam") {
                                                              if (docs['info-title'] == "The First City of Islam") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                              if (docs['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "Umawiyyah Kingdom") {
                                                              if (docs['info-title'] == "Umawiyyah Kingdom") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "Abbasiyyah Kingdom") {
                                                              if (docs['info-title'] == "Abbasiyyah Kingdom") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "The First City of Islam") {
                                                              if (docs['info-title'] == "The First City of Islam") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoEmpire(
                                                                                _glorious)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                              if (docs['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoEmpire(
                                                                                _glorious)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Umawiyyah Kingdom") {
                                                              if (docs['info-title'] == "Umawiyyah Kingdom") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoEmpire(
                                                                                _glorious)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Abbasiyyah Kingdom") {
                                                              if (docs['info-title'] == "Abbasiyyah Kingdom") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoEmpire(
                                                                                _glorious)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  living_things.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _livingthings = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "Ancient Flora & Fauna") {
                                                              if (docs['info-title'] == "Ancient Flora & Fauna") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "Homo Erectus & Their Species") {
                                                              if (docs['info-title'] == "Homo Erectus & Their Species") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "Ancient Flora & Fauna") {
                                                              if (docs['info-title'] == "Ancient Flora & Fauna") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoLivingThings(
                                                                                _livingthings)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "Homo Erectus & Their Species") {
                                                              if (docs['info-title'] == "Homo Erectus & Their Species") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoLivingThings(
                                                                                _livingthings)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });


                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  exist.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _theExist = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "The Creation of Sky and Earth") {
                                                              if (docs['info-title'] == "The Creation of Sky and Earth") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "The Creation of Sky and Earth") {
                                                              if (docs['info-title'] == "The Creation of Sky and Earth") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoTheExistence(
                                                                                _theExist)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {

                                                  homosapiens.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _homosapiens = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {

                                                            //the creation of water
                                                            if (data['info-title'] == "Adam a.s.") {
                                                              if (docs['info-title'] == "Adam a.s.") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            if (data['info-title'] == "His Children") {
                                                              if (docs['info-title'] == "His Children") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "His Wife") {
                                                              if (docs['info-title'] == "His Wife") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }

                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "Adam a.s.") {
                                                              if (docs['info-title'] == "Adam a.s.") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoHomosapiens(
                                                                                _homosapiens)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "His Children") {
                                                              if (docs['info-title'] == "His Children") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoHomosapiens(
                                                                                _homosapiens)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "His Wife") {
                                                              if (docs['info-title'] == "His Wife") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoHomosapiens(
                                                                                _homosapiens)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              userRole.get().then((QuerySnapshot snapshot) {
                                                snapshot.docs.forEach((DocumentSnapshot doc) {
                                                  //todo: Before The Creation of Universe
                                                  before.get().then((QuerySnapshot snap) {
                                                    snap.docs.forEach((DocumentSnapshot docs) {
                                                      final _beforeExist = docs;
                                                      setState(() {
                                                        //doc from before the existence
                                                        //data = tamadun-info
                                                        if (doc['email'] == currUser) {
                                                          //todo : Standard Role
                                                          if (doc['role'] == 'standard') {
                                                            if (data['info-title'] == "The Creation of Qalam") {
                                                              if (docs['info-title'] == "The Creation of Qalam") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoBeforeExistence(
                                                                                _beforeExist)));
                                                              }
                                                            }

                                                            //the creation of water
                                                            if (data['info-title'] == "The Creation of Water") {
                                                              if (docs['info-title'] == "The Creation of Water") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }

                                                            //the creation of arash
                                                            if (data['info-title'] == "The Creation of Arash") {
                                                              if (docs['info-title'] == "The Creation of Arash") {
                                                                showFloatingFlushbar(
                                                                    context: context,
                                                                    message:
                                                                    'Upgrade to Premium Now !!',
                                                                    isError: false);
                                                              }
                                                            }
                                                          }
                                                          //todo: Premium Role
                                                          if (doc['role'] == 'premium') {
                                                            if (data['info-title'] == "The Creation of Qalam") {
                                                              if (docs['info-title'] == "The Creation of Qalam") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoBeforeExistence(
                                                                                _beforeExist)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "The Creation of Water") {
                                                              if (docs['info-title'] == "The Creation of Water") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoBeforeExistence(
                                                                                _beforeExist)));
                                                              }
                                                            }
                                                            if (data['info-title'] == "The Creation of Arash") {
                                                              if (docs['info-title'] == "The Creation of Arash") {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            InfoBeforeExistence(
                                                                                _beforeExist)));
                                                              }
                                                            }
                                                          }
                                                        }
                                                      });
                                                    });
                                                  });
                                                }
                                                );
                                              });

                                              // //todo:Prophets / the Ummah
                                              // final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
                                              // prophet.get()
                                              //     .then((
                                              //     QuerySnapshot snapshots) {
                                              //   snapshots.docs
                                              //       .forEach((
                                              //       DocumentSnapshot docs) {
                                              //     final _ummah = docs;
                                              //     setState(() {
                                              //       if (data["info-title"] ==
                                              //           docs["info-title"]) {
                                              //         print(
                                              //             data["info-title"]);
                                              //         print(
                                              //             docs.id);
                                              //         print(
                                              //             docs["info-title"]);
                                              //         print(
                                              //             docs .id);
                                              //         print(
                                              //             _ummah
                                              //                 .id);
                                              //         Navigator
                                              //             .push(
                                              //             context,
                                              //             MaterialPageRoute(
                                              //                 builder: (
                                              //                     context) =>
                                              //                     TheProphet(
                                              //                         _ummah)));
                                              //       }
                                              //     });
                                              //   });
                                              // });


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

                                    //todo:lock search topic before-existence [/]
                                    final userRole = FirebaseFirestore.instance
                                        .collection("Users");
                                    final currUser =
                                        FirebaseAuth.instance.currentUser!.email;
                                    final before = FirebaseFirestore.instance
                                        .collection('before-the-existence');
                                    final exist = FirebaseFirestore.instance
                                        .collection('the-existence-of-universe');
                                    final homosapiens = FirebaseFirestore.instance
                                        .collection('first-man-on-earth');
                                    final living_things = FirebaseFirestore.instance
                                        .collection('living-things');
                                    final glorious = FirebaseFirestore.instance
                                        .collection('the-islamic-empire');
                                    final monathestic = FirebaseFirestore.instance
                                        .collection('monathestic-empire');
                                    final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");

                                    //get user role
                                    //todo: prophet/ummah
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        prophet.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _ummah = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "Prophet Adam a.s.)") {
                                                    if (docs['info-title'] == "Prophet Adam a.s.)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Prophet Idris a.s.") {
                                                    if (docs['info-title'] == "Prophet Idris a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Prophet Nuh a.s.") {
                                                    if (docs['info-title'] == "Prophet Nuh a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Prophet Hud a.s.") {
                                                    if (docs['info-title'] == "Prophet Hud a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Saleh a.s.") {
                                                    if (docs['info-title'] == "Prophet Saleh a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ibrahim a.s.") {
                                                    if (docs['info-title'] == "Prophet Ibrahim a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Luth a.s.") {
                                                    if (docs['info-title'] == "Prophet Luth a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ismail a.s.") {
                                                    if (docs['info-title'] == "Prophet Ismail a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ishaq a.s.") {
                                                    if (docs['info-title'] == "Prophet Ishaq a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yaqub a.s.") {
                                                    if (docs['info-title'] == "Prophet Yaqub a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yusuf a.s.") {
                                                    if (docs['info-title'] == "Prophet Yusuf a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ayyub a.s.") {
                                                    if (docs['info-title'] == "Prophet Ayyub a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Syuib a.s.") {
                                                    if (docs['info-title'] == "Prophet Syuib a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Musa a.s.") {
                                                    if (docs['info-title'] == "Prophet Musa a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Harun a.s.") {
                                                    if (docs['info-title'] == "Prophet Harun a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Zulkifli a.s.") {
                                                    if (docs['info-title'] == "Prophet Zulkifli a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Daud a.s.") {
                                                    if (docs['info-title'] == "Prophet Daud a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Sulaiman a.s.") {
                                                    if (docs['info-title'] == "Prophet Sulaiman a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ilyas a.s.") {
                                                    if (docs['info-title'] == "Prophet Ilyas a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ilyasa a.s.") {
                                                    if (docs['info-title'] == "Prophet Ilyasa a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yunus a.s.") {
                                                    if (docs['info-title'] == "Prophet Yunus a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Zakaria a.s.") {
                                                    if (docs['info-title'] == "Prophet Zakaria a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yahya a.s.") {
                                                    if (docs['info-title'] == "Prophet Yahya a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "Prophet Isa a.s.") {
                                                    if (docs['info-title'] == "Prophet Isa a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Muhammad s.a.w.") {
                                                    if (docs['info-title'] == "Prophet Muhammad s.a.w.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "Prophet Adam a.s.") {
                                                    if (docs['info-title'] == "Prophet Adam a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Idris a.s.") {
                                                    if (docs['info-title'] == "Prophet Idris a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Nuh a.s.") {
                                                    if (docs['info-title'] == "Prophet Nuh a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Hud a.s.") {
                                                    if (docs['info-title'] == "Prophet Hud a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Saleh a.s.") {
                                                    if (docs['info-title'] == "Prophet Saleh a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ibrahim a.s.") {
                                                    if (docs['info-title'] == "Prophet Ibrahim a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Luth a.s.") {
                                                    if (docs['info-title'] == "Prophet Luth a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ismail a.s.") {
                                                    if (docs['info-title'] == "Prophet Ismail a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ishaq a.s.") {
                                                    if (docs['info-title'] == "Prophet Ishaq a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yaqub a.s.") {
                                                    if (docs['info-title'] == "Prophet Yaqub a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yusuf a.s.") {
                                                    if (docs['info-title'] == "Prophet Yusuf a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ayyub a.s.") {
                                                    if (docs['info-title'] == "Prophet Ayyub a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Syuib a.s.") {
                                                    if (docs['info-title'] == "Prophet Syuib a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Musa a.s.") {
                                                    if (docs['info-title'] == "Prophet Musa a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Harun a.s.") {
                                                    if (docs['info-title'] == "Prophet Harun a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Zulkifli a.s.") {
                                                    if (docs['info-title'] == "Prophet Zulkifli a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Daud a.s.") {
                                                    if (docs['info-title'] == "Prophet Daud a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Sulaiman a.s.") {
                                                    if (docs['info-title'] == "Prophet Sulaiman a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ilyas a.s.") {
                                                    if (docs['info-title'] == "Prophet Ilyas a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Ilyasa a.s.") {
                                                    if (docs['info-title'] == "Prophet Ilyasa a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yunus a.s.") {
                                                    if (docs['info-title'] == "Prophet Yunus a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Zakaria a.s.") {
                                                    if (docs['info-title'] == "Prophet Zakaria a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Yahya a.s.") {
                                                    if (docs['info-title'] == "Prophet Yahya a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Isa a.s.") {
                                                    if (docs['info-title'] == "Prophet Isa a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Prophet Muhammad s.a.w.") {
                                                    if (docs['info-title'] == "Prophet Muhammad s.a.w.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TheProphet(
                                                                      _ummah)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    //todo: monatheistic
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        monathestic.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _monathestic = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                    if (docs['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                    if (docs['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                    if (docs['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Syariat Injil (Isa a.s)") {
                                                    if (docs['info-title'] == "Syariat Injil (Isa a.s)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                    if (docs['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                    if (docs['info-title'] == "Syariat Hanifa (Ibrahim a.s)") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoMonathestic(
                                                                      _monathestic)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                    if (docs['info-title'] == "Syariat Zabur (Daud a.s)") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoMonathestic(
                                                                      _monathestic)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                    if (docs['info-title'] == "Syariat Taurat (Musa a.s)") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoMonathestic(
                                                                      _monathestic)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Syariat Injil (Isa a.s)") {
                                                    if (docs['info-title'] == "Syariat Injil (Isa a.s)") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoMonathestic(
                                                                      _monathestic)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                    if (docs['info-title'] == "Al-Quran (Muhammad S.A.W)") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoMonathestic(
                                                                      _monathestic)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        glorious.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _glorious = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "The First City of Islam") {
                                                    if (docs['info-title'] == "The First City of Islam") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                    if (docs['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "Umawiyyah Kingdom") {
                                                    if (docs['info-title'] == "Umawiyyah Kingdom") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "Abbasiyyah Kingdom") {
                                                    if (docs['info-title'] == "Abbasiyyah Kingdom") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "The First City of Islam") {
                                                    if (docs['info-title'] == "The First City of Islam") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoEmpire(
                                                                      _glorious)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                    if (docs['info-title'] == "Khulafa’ al-Rashidin and the Era of Tabi’ al-Tabi’in") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoEmpire(
                                                                      _glorious)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Umawiyyah Kingdom") {
                                                    if (docs['info-title'] == "Umawiyyah Kingdom") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoEmpire(
                                                                      _glorious)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Abbasiyyah Kingdom") {
                                                    if (docs['info-title'] == "Abbasiyyah Kingdom") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoEmpire(
                                                                      _glorious)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        living_things.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _livingthings = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "Ancient Flora & Fauna") {
                                                    if (docs['info-title'] == "Ancient Flora & Fauna") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "Homo Erectus & Their Species") {
                                                    if (docs['info-title'] == "Homo Erectus & Their Species") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "Ancient Flora & Fauna") {
                                                    if (docs['info-title'] == "Ancient Flora & Fauna") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoLivingThings(
                                                                      _livingthings)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "Homo Erectus & Their Species") {
                                                    if (docs['info-title'] == "Homo Erectus & Their Species") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoLivingThings(
                                                                      _livingthings)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });


                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        exist.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _theExist = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "The Creation of Sky and Earth") {
                                                    if (docs['info-title'] == "The Creation of Sky and Earth") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "The Creation of Sky and Earth") {
                                                    if (docs['info-title'] == "The Creation of Sky and Earth") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoTheExistence(
                                                                      _theExist)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {

                                        homosapiens.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _homosapiens = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {

                                                  //the creation of water
                                                  if (data['info-title'] == "Adam a.s.") {
                                                    if (docs['info-title'] == "Adam a.s.") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  if (data['info-title'] == "His Children") {
                                                    if (docs['info-title'] == "His Children") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "His Wife") {
                                                    if (docs['info-title'] == "His Wife") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }

                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "Adam a.s.") {
                                                    if (docs['info-title'] == "Adam a.s.") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoHomosapiens(
                                                                      _homosapiens)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "His Children") {
                                                    if (docs['info-title'] == "His Children") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoHomosapiens(
                                                                      _homosapiens)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "His Wife") {
                                                    if (docs['info-title'] == "His Wife") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoHomosapiens(
                                                                      _homosapiens)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        //todo: Before The Creation of Universe
                                        before.get().then((QuerySnapshot snap) {
                                          snap.docs.forEach((DocumentSnapshot docs) {
                                            final _beforeExist = docs;
                                            setState(() {
                                              //doc from before the existence
                                              //data = tamadun-info
                                              if (doc['email'] == currUser) {
                                                //todo : Standard Role
                                                if (doc['role'] == 'standard') {
                                                  if (data['info-title'] == "The Creation of Qalam") {
                                                    if (docs['info-title'] == "The Creation of Qalam") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist)));
                                                    }
                                                  }

                                                  //the creation of water
                                                  if (data['info-title'] == "The Creation of Water") {
                                                    if (docs['info-title'] == "The Creation of Water") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }

                                                  //the creation of arash
                                                  if (data['info-title'] == "The Creation of Arash") {
                                                    if (docs['info-title'] == "The Creation of Arash") {
                                                      showFloatingFlushbar(
                                                          context: context,
                                                          message:
                                                          'Upgrade to Premium Now !!',
                                                          isError: false);
                                                    }
                                                  }
                                                }
                                                //todo: Premium Role
                                                if (doc['role'] == 'premium') {
                                                  if (data['info-title'] == "The Creation of Qalam") {
                                                    if (docs['info-title'] == "The Creation of Qalam") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "The Creation of Water") {
                                                    if (docs['info-title'] == "The Creation of Water") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist)));
                                                    }
                                                  }
                                                  if (data['info-title'] == "The Creation of Arash") {
                                                    if (docs['info-title'] == "The Creation of Arash") {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  InfoBeforeExistence(
                                                                      _beforeExist)));
                                                    }
                                                  }
                                                }
                                              }
                                            });
                                          });
                                        });
                                      }
                                      );
                                    });

                                    // //todo:Prophets / the Ummah
                                    // final prophet = FirebaseFirestore.instance.collection('ummah').doc('the-prophets').collection("prophets-button");
                                    // prophet.get()
                                    //     .then((
                                    //     QuerySnapshot snapshots) {
                                    //   snapshots.docs
                                    //       .forEach((
                                    //       DocumentSnapshot docs) {
                                    //     final _ummah = docs;
                                    //     setState(() {
                                    //       if (data["info-title"] ==
                                    //           docs["info-title"]) {
                                    //         print(
                                    //             data["info-title"]);
                                    //         print(
                                    //             docs.id);
                                    //         print(
                                    //             docs["info-title"]);
                                    //         print(
                                    //             docs .id);
                                    //         print(
                                    //             _ummah
                                    //                 .id);
                                    //         Navigator
                                    //             .push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (
                                    //                     context) =>
                                    //                     TheProphet(
                                    //                         _ummah)));
                                    //       }
                                    //     });
                                    //   });
                                    // });


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