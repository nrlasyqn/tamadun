import 'package:tamadun/auth/auth.dart';
import 'package:tamadun/screens/user_profile_page.dart';
import 'package:tamadun/authentication/log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/facebook_auth.dart';
import '../auth/google_auth.dart';
import 'aboutus.dart';
import 'mainbody.dart';

//morepage
class MoreScreen extends StatefulWidget {
  bool isGmail = false;

  MoreScreen({required this.isGmail, Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String aqwiseURL = 'https://tinyimg.io/i/gRsrF16.jpg';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  AuthService authService = AuthService();
  AuthFacebook authFacebook = AuthFacebook();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>mainbody()));
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          // if user login through google or facebook
          child: widget.isGmail
              ? ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(hexColor('E7E7E7')))),
                      ),
                      //user profile
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(authService.getUserPicture()),
                        ),
                        title: Text("${authService.getUserdisplayname()}",
                            style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 16,
                              color: Colors.black,
                            )),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUserScreen()));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(
                              hexColor('E7E7E7'),
                            ),
                          ),
                        ),
                      ),
                      //aq wise info
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(aqwiseURL),
                        ),
                        title: Text('About Us',
                            style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 16,
                              color: Colors.black,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => aboutus()));
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      margin: EdgeInsets.all(20),
                      width: 30,
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          authService.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }), ModalRoute.withName('/'));
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black, width: 1)),
                        color: Colors.white,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   "Welcome \nMr. ${authService.getUserdisplayname()}",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                  ],
                )
              //if user login through normal login
              : ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(hexColor('E7E7E7')))),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(loggedInUser.photoURL ??
                              "http://cdn.onlinewebfonts.com/svg/img_24787.png"),
                        ),
                        title: Text("${loggedInUser.displayName}",
                            style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 16,
                              color: Colors.black,
                            )),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUserScreen()));
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(
                              hexColor('E7E7E7'),
                            ),
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(aqwiseURL),
                        ),
                        title: Text('About Us',
                            style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 16,
                              color: Colors.black,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => aboutus()));
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 80),
                      margin: EdgeInsets.all(20),
                      width: 30,
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () async {
                          final User? user = await firebaseAuth.currentUser;
                          if (user == null) {
                            Scaffold.of(context).showSnackBar(const SnackBar(
                              content: Text('No one has signed in.'),
                            ));
                            return;
                          }
                          signOut();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoginScreen()));
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black, width: 1)),
                        color: Colors.white,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void signOut() async {
    await firebaseAuth.signOut().then((value) => {
      setState(() {
        user = null;
      })
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
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
