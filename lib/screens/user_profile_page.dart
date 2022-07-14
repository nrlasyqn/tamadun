

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/profile.dart';
import '../auth/google_auth.dart';
import '../auth/auth.dart';
import '../authentication/log.dart';

//user profile
class ProfileUserScreen extends StatefulWidget {

  ProfileUserScreen({Key? key}) : super(key: key);

  @override
  _ProfileUserScreenState createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser;
  AuthService authService = AuthService();



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Expanded(child:
              Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 110, bottom: 10, right: 0, top: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgProfile.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),),
                  height: 240.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("     ${loggedInUser!.displayName ??
                        authService
                            .getUserdisplayname()} \n      ${loggedInUser!
                        .role ?? authService.getUserRole()}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsSemiBold',
                        color: Colors.white,
                      ),),
                  ),
                ),

                SizedBox(height: 15),
                Container(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(hexColor('F1F1F1')),
                      border: Border.all(
                        width: 1, color: Color(
                        hexColor('A9A4A4'),
                      ),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("     ${loggedInUser!.email ?? authService.getUserEmail()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(
                          hexColor('F1F1F1')),
                      border: Border.all(
                        width: 1, color: Color(
                        hexColor('A9A4A4'),
                      ),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("     ${loggedInUser!.bio ?? authService.getUserBio()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditProfile()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Color(
                          hexColor('FFFFFF')),
                      border: Border.all(
                          width: 1, color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text("Edit",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsRegular',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                ),


              ]
              ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

// the logout function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginScreen();}), ModalRoute.withName('/'));
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