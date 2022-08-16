
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/screens/home_page.dart';
import 'package:tamadun/screens/snackbar.dart';
import 'package:tamadun/screens/the_existence.dart';
import 'package:tamadun/timeline/timeline_beforebigbang.dart';
import 'empierofislam.dart';

class universe extends StatefulWidget {
  @override
  _universeClassState createState() => _universeClassState();
}

class _universeClassState extends State<universe> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(109, 126, 168, 1.0),
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
            .doc('before-existence')
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
                  ?Stack(
                children: [
                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                      height: size.height,
                      width: size.width,
                      decoration: const BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                const Color.fromRGBO(109, 126, 168, 1.0),
                                const Color.fromRGBO(109, 126, 168, 1.0),
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
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${snapshot.data!['title']}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'PoppinsSemiBold',
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 80.0,
                        ),
                        //todo:The Creation of Qalam [FREE]
                        Container(
                          width: 300,
                          child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FetchTimelineBefore()));
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2)),
                              elevation: 0.0,
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!['topic-1']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'PoppinsMedium',
                                    color: Colors.black,
                                  ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),


                        Container(
                          width: 300,
                          //todo: payment gateway [/]
                          child: MaterialButton(
                              onPressed: () {
                                final userRole = FirebaseFirestore.instance.collection("Users");
                                userRole.get().then((QuerySnapshot snapshot) {
                                  snapshot.docs.forEach((DocumentSnapshot doc) {
                                    final currUser = FirebaseAuth.instance.currentUser!.email;
                                    if (doc['email'] == currUser) {
                                      if (doc['role'] == 'standard') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        showFloatingFlushbar(
                                            context: context,
                                            message:
                                            'Upgrade to Premium Now !!',
                                            isError: false);
                                      }
                                      if (doc['role'] == 'premium') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FetchTimelineBefore()));
                                        }

                                        );}
                                    }});
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2)),
                              elevation: 0.0,
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!['topic-2']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'PoppinsMedium',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        //todo: The Creation of Arash [NOT FREE]
                        Container(
                          width: 300,
                          child: MaterialButton(
                              onPressed: () {
                                final userRole = FirebaseFirestore.instance.collection("Users");
                                userRole.get().then((QuerySnapshot snapshot) {
                                  snapshot.docs.forEach((DocumentSnapshot doc) {
                                    final currUser = FirebaseAuth.instance.currentUser!.email;
                                    if (doc['email'] == currUser) {
                                      if (doc['role'] == 'standard') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        showFloatingFlushbar(
                                            context: context,
                                            message:
                                            'Upgrade to Premium Now !!',
                                            isError: false);
                                      }
                                      if (doc['role'] == 'premium') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FetchTimelineBefore()));
                                      }
                                    }
                                  });
                                });
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2)),
                              elevation: 0.0,
                              padding: const EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${snapshot.data!['topic-3']}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: const EdgeInsets.all(20.0),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 30,
                          ),
                          onPressed: () {
                            //todo: lock
                            final userRole = FirebaseFirestore.instance.collection("Users");
                            userRole.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final currUser = FirebaseAuth.instance.currentUser!.email;
                                if (doc['email'] == currUser) {
                                  if (doc['role'] == 'standard') {
                                    print(doc['role']);
                                    print(doc['email']);
                                    showAskUserBar(
                                        context: context,
                                        message:
                                        'Upgrade to Premium Now !!',
                                        isError: false);
                                  }
                                  if (doc['role'] == 'premium') {
                                    print(doc['role']);
                                    print(doc['email']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => empierofislam()));
                                  }
                                }
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.width,
                    width: size.width,
                    margin: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                          ),
                          onPressed: () {
                            //todo: lock
                            final userRole = FirebaseFirestore.instance.collection("Users");
                            userRole.get().then((QuerySnapshot snapshot) {
                              snapshot.docs.forEach((DocumentSnapshot doc) {
                                final currUser = FirebaseAuth.instance.currentUser!.email;
                                if (doc['email'] == currUser) {
                                  if (doc['role'] == 'standard') {
                                    print(doc['role']);
                                    print(doc['email']);
                                    showAskUserBar(
                                        context: context,
                                        message:
                                        'Upgrade to Premium Now !!',
                                        isError: false);
                                  }
                                  if (doc['role'] == 'premium') {
                                    print(doc['role']);
                                    print(doc['email']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => the_existence()));
                                  }
                                }
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
//todo:tablet android view
                  :SingleChildScrollView(
                  child: screenWidth < 1200
                      ?Stack(
                    children: [
                      ClipPath(
                        clipper: DrawCliptablet(),
                        child: Container(
                          height: size.height,
                          width: size.width,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(109, 126, 168, 1.0),
                                    Color.fromRGBO(109, 126, 168, 1.0),
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
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
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
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "${snapshot.data!['title']}",
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'PoppinsSemiBold',
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 110.0,
                            ),
                            //todo:The Creation of Qalam [FREE]
                            Container(
                              width: 400,
                              child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FetchTimelineBefore()));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  elevation: 0.0,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 500.0, minHeight: 70.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${snapshot.data!['topic-1']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'PoppinsMedium',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),


                            Container(
                              width: 400,
                              //todo: payment gateway [/]
                              child: MaterialButton(
                                  onPressed: () {
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FetchTimelineBefore()));
                                            }

                                            );}
                                        }});
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  elevation: 0.0,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 500.0, minHeight: 70.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${snapshot.data!['topic-2']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'PoppinsMedium',
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),

                            //todo: The Creation of Arash [NOT FREE]
                            Container(
                              width: 400,
                              child: MaterialButton(
                                  onPressed: () {
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            showFloatingFlushbar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const FetchTimelineBefore()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                      side: const BorderSide(
                                          color: Colors.black, width: 2)),
                                  elevation: 0.0,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 500.0, minHeight: 70.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${snapshot.data!['topic-3']}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
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
                        margin: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                //todo: lock
                                final userRole = FirebaseFirestore.instance.collection("Users");
                                userRole.get().then((QuerySnapshot snapshot) {
                                  snapshot.docs.forEach((DocumentSnapshot doc) {
                                    final currUser = FirebaseAuth.instance.currentUser!.email;
                                    if (doc['email'] == currUser) {
                                      if (doc['role'] == 'standard') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        showAskUserBar(
                                            context: context,
                                            message:
                                            'Upgrade to Premium Now !!',
                                            isError: false);
                                      }
                                      if (doc['role'] == 'premium') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => empierofislam()));
                                      }
                                    }
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width,
                        width: size.width,
                        margin: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 40,
                              ),
                              onPressed: () {
                                //todo: lock
                                final userRole = FirebaseFirestore.instance.collection("Users");
                                userRole.get().then((QuerySnapshot snapshot) {
                                  snapshot.docs.forEach((DocumentSnapshot doc) {
                                    final currUser = FirebaseAuth.instance.currentUser!.email;
                                    if (doc['email'] == currUser) {
                                      if (doc['role'] == 'standard') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        showAskUserBar(
                                            context: context,
                                            message:
                                            'Upgrade to Premium Now !!',
                                            isError: false);
                                      }
                                      if (doc['role'] == 'premium') {
                                        print(doc['role']);
                                        print(doc['email']);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => the_existence()));
                                      }
                                    }
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
//todo:ipad view
                      :SingleChildScrollView(
                      child: screenWidth < 2800
                          ?Stack(
                        children: [
                          ClipPath(
                            clipper: DrawCliptablet(),
                            child: Container(
                              height: size.height,
                              width: size.width,
                              decoration: const BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        const Color.fromRGBO(109, 126, 168, 1.0),
                                        const Color.fromRGBO(109, 126, 168, 1.0),
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
                                const SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
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
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "${snapshot.data!['title']}",
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'PoppinsSemiBold',
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 130.0,
                                ),
                                //todo:The Creation of Qalam [FREE]
                                Container(
                                  width: 400,
                                  child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FetchTimelineBefore()));
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80.0),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2)),
                                      elevation: 0.0,
                                      padding: const EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500.0, minHeight: 70.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${snapshot.data!['topic-1']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'PoppinsMedium',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),


                                Container(
                                  width: 400,
                                  //todo: payment gateway [/]
                                  child: MaterialButton(
                                      onPressed: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now !!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const FetchTimelineBefore()));
                                                }

                                                );}
                                            }});
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80.0),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2)),
                                      elevation: 0.0,
                                      padding: const EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500.0, minHeight: 70.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${snapshot.data!['topic-2']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'PoppinsMedium',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),

                                //todo: The Creation of Arash [NOT FREE]
                                Container(
                                  width: 400,
                                  child: MaterialButton(
                                      onPressed: () {
                                        final userRole = FirebaseFirestore.instance.collection("Users");
                                        userRole.get().then((QuerySnapshot snapshot) {
                                          snapshot.docs.forEach((DocumentSnapshot doc) {
                                            final currUser = FirebaseAuth.instance.currentUser!.email;
                                            if (doc['email'] == currUser) {
                                              if (doc['role'] == 'standard') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                showFloatingFlushbar(
                                                    context: context,
                                                    message:
                                                    'Upgrade to Premium Now !!',
                                                    isError: false);
                                              }
                                              if (doc['role'] == 'premium') {
                                                print(doc['role']);
                                                print(doc['email']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const FetchTimelineBefore()));
                                              }
                                            }
                                          });
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(80.0),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2)),
                                      elevation: 0.0,
                                      padding: const EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 500.0, minHeight: 70.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${snapshot.data!['topic-3']}",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
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
                            margin: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    //todo: lock
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            showAskUserBar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => empierofislam()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: size.width,
                            width: size.width,
                            margin: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    //todo: lock
                                    final userRole = FirebaseFirestore.instance.collection("Users");
                                    userRole.get().then((QuerySnapshot snapshot) {
                                      snapshot.docs.forEach((DocumentSnapshot doc) {
                                        final currUser = FirebaseAuth.instance.currentUser!.email;
                                        if (doc['email'] == currUser) {
                                          if (doc['role'] == 'standard') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            showAskUserBar(
                                                context: context,
                                                message:
                                                'Upgrade to Premium Now !!',
                                                isError: false);
                                          }
                                          if (doc['role'] == 'premium') {
                                            print(doc['role']);
                                            print(doc['email']);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => the_existence()));
                                          }
                                        }
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ):null
                    // "${snapshot.data!['title']}",

                  ))):Container();
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
class DrawCliptablet extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(size.width * 0.5, -100), radius: 520));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}