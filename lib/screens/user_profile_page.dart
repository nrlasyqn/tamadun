// import 'package:flutter/material.dart';
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter FB Story Icon ex',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter FB Story Icon ex'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: CircleAvatar(
//               radius: 135,
//               backgroundColor: Colors.blue,
//               child: CircleAvatar(
//                 radius: 125,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 115,
//                   backgroundImage: NetworkImage(
//                       'https://cdn.pixabay.com/photo/2018/01/15/07/52/woman-3083390_1280.jpg'),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamadun/auth/facebook_auth.dart';
import 'package:tamadun/testing/text.dart';
import 'package:tamadun/widget/profilemenu_more.dart';
import '../auth/auth.dart';
import '../auth/google_auth.dart';
import '../authentication/log.dart';
import '../screens/aboutus.dart';
import '../screens/home_page.dart';
import '../screens/user_profile_page.dart';
import 'user_edit_profile.dart';
import '../widget/constant.dart';

//user profile
class Profile_view extends StatefulWidget {
  bool isGmail = false;
  Profile_view({required this.isGmail, Key? key}) : super(key: key);

  @override
  _Profile_viewState createState() => _Profile_viewState();
}

class _Profile_viewState extends State<Profile_view> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel? loggedInUser = UserModel();
  AuthService authService = AuthService();
  AuthFacebook authFacebook = AuthFacebook();

  String? ImageUrl;
  XFile? xfile;
  late File file;
  File? pickedImage;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.isGmail
                ?  Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: mMorePageColor,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: pickedImage == null
                                ? NetworkImage(loggedInUser?.photoURL! == ''
                                ? 'https://freesvg.org/img/abstract-user-flat-4.png'
                                : loggedInUser!.photoURL!)
                                : FileImage(pickedImage!) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.displayName ?? authService.getUserdisplayname()}", style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.role ?? authService.getUserRole()}", style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsItalic',
                        fontSize: 16,
                      ),),
                    ),
                    SizedBox(height:20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(" Email Address",style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(hexColor('FFF5F6F9')),
                              border: Border.all(
                                width: 1,
                                color: Color(
                                  hexColor('A9A4A4'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "${loggedInUser!.email ?? authFacebook.getUserEmail()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(" Bio",style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(hexColor('FFF5F6F9')),
                              border: Border.all(
                                width: 1,
                                color: Color(
                                  hexColor('A9A4A4'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "${loggedInUser!.bio ?? authFacebook.getUserBio()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        ProfileWidget(
                          text: "Edit Profile",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            )
                : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: mMorePageColor,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: pickedImage == null
                                ? NetworkImage(loggedInUser?.photoURL! == ''
                                ? 'https://freesvg.org/img/abstract-user-flat-4.png'
                                : loggedInUser!.photoURL!)
                                : FileImage(pickedImage!) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.displayName ?? authFacebook.getUserdisplayname()}", style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.role ?? authFacebook.getUserRole()}", style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsItalic',
                        fontSize: 16,
                      ),),
                    ),
                    SizedBox(height:20.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(" Email Address",style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(hexColor('FFF5F6F9')),
                              border: Border.all(
                                width: 1,
                                color: Color(
                                  hexColor('A9A4A4'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "${loggedInUser!.email ?? authFacebook.getUserEmail()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Text(" Bio",style: TextStyle(
                          fontFamily: 'PoppinsRegular',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 50,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Color(hexColor('FFF5F6F9')),
                              border: Border.all(
                                width: 1,
                                color: Color(
                                  hexColor('A9A4A4'),
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "${loggedInUser!.bio ?? authFacebook.getUserBio()}",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        ProfileWidget(
                          text: "Edit Profile",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// the logout function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), ModalRoute.withName('/'));
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
