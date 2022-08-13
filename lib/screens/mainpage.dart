import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamadun/screens/monotheistic_empire.dart';
import 'package:tamadun/screens/snackbar.dart';
import 'package:tamadun/screens/the_existence.dart';
import 'package:tamadun/screens/living_things.dart';
import 'package:flutter/material.dart';
import '../widget/constant.dart';
import 'beforetheexistence.dart';
import 'empierofislam.dart';
import 'homosapiens.dart';
import 'the_ummah.dart';
import 'monotheistic_empire.dart';

class MainPage extends StatefulWidget {
  //MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final db = FirebaseFirestore.instance;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _isloading = true;
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isloading = false;
      });
    });
  }
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Ummah Empire',
          style: TextStyle(
            fontFamily: "MontserratBold",
            fontSize: 24,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: _isloading ? Center(
        child: CircularProgressIndicator(
          color: Color(hexColor('#25346a')),
        ),
      ):FutureBuilder<DocumentSnapshot>(
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
            //todo:mobile view
              child: screenWidth < 576
                  ? Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
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
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'Before The Creation of Universe',
                                          "${snapshot.data!['title'][0]}",
                                          style: const TextStyle(
                                            fontFamily: 'PoppinsSemiBold',
                                            fontSize: 16,
                                            color: Colors.white,
                                          )),
                                      Text("${snapshot.data!['secTitle'][0]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        the_existence()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               the_existence()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][1]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                          "${snapshot.data!['title'][1]}",
                                          style: const TextStyle(
                                            fontFamily: 'PoppinsSemiBold',
                                            fontSize: 16,
                                            color: Colors.white,
                                          )),
                                      Text(
                                        // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                          "${snapshot.data!['secTitle'][1]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        living_things()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               living_things()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][2]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'Living Things Before Creation of Man',
                                          "${snapshot.data!['title'][2]}",
                                          style: const TextStyle(
                                            fontFamily: 'PoppinsSemiBold',
                                            fontSize: 16,
                                            color: Colors.white,
                                          )),
                                      Text(
                                        //'Living Things Before Creation of Man',
                                          "${snapshot.data!['secTitle'][2]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        homosapiens()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               homosapiens()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][3]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'The First Man on Earth',
                                          "${snapshot.data!['title'][3]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ummah()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ummah()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][4]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'The Islamic Empier',
                                          "${snapshot.data!['title'][4]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        monotheistic_empire()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               monotheistic_empire()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][5]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'The Islamic Empier',
                                          "${snapshot.data!['title'][5]}",
                                          style: const TextStyle(
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
                        const SizedBox(height: 20),
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
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            // print(doc['role']);
                                            // print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now!!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        empierofislam()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               empierofislam()));
                                  // },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage("${snapshot.data!['image'][6]}"),
                                        height: 130,
                                        width: double.maxFinite,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //'The Islamic Empier',
                                          "${snapshot.data!['title'][6]}",
                                          style: const TextStyle(
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
                        const SizedBox(
                          height: 30,
                        ),
                      ]))

              //todo:tablet view
                  :SingleChildScrollView(
                  child: screenWidth < 992
                      ? Container(

                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
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
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'Before The Creation of Universe',
                                              "${snapshot.data!['title'][0]}",
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsSemiBold',
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                          Text("${snapshot.data!['secTitle'][0]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),

                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            the_existence()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               the_existence()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][1]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                              "${snapshot.data!['title'][1]}",
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsSemiBold',
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                          Text(
                                            // '       The Starting Point of\nUniverse Creation (Big Bang)',
                                              "${snapshot.data!['secTitle'][1]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            living_things()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               living_things()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][2]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'Living Things Before Creation of Man',
                                              "${snapshot.data!['title'][2]}",
                                              style: const TextStyle(
                                                fontFamily: 'PoppinsSemiBold',
                                                fontSize: 16,
                                                color: Colors.white,
                                              )),
                                          Text(
                                            //'Living Things Before Creation of Man',
                                              "${snapshot.data!['secTitle'][2]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            homosapiens()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               homosapiens()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][3]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'The First Man on Earth',
                                              "${snapshot.data!['title'][3]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ummah()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               ummah()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][4]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'The Islamic Empier',
                                              "${snapshot.data!['title'][4]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            monotheistic_empire()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               monotheistic_empire()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][5]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'The Islamic Empier',
                                              "${snapshot.data!['title'][5]}",
                                              style: const TextStyle(
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
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                                  child: Material(
                                    color: Colors.black54,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(18),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                // print(doc['role']);
                                                // print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now!!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            empierofislam()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      // onTap: () {
                                      //   Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               empierofislam()));
                                      // },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Ink.image(
                                            image: NetworkImage("${snapshot.data!['image'][6]}"),
                                            height: 200,
                                            width: double.maxFinite,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            //'The Islamic Empier',
                                              "${snapshot.data!['title'][6]}",
                                              style: const TextStyle(
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
                            const SizedBox(
                              height: 20,
                            ),
                          ])):null
              )
          ) :Container();

        },
      ),
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