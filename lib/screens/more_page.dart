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
import 'package:tamadun/webview.dart';
import 'package:tamadun/widget/profilemenu_more.dart';
import '../auth/auth.dart';
import '../auth/google_auth.dart';
import '../authentication/log.dart';
import '../screens/aboutus.dart';
import '../screens/home_page.dart';
import '../screens/user_profile_page.dart';
import '../widget/constant.dart';

//morepage
class Morepage extends StatefulWidget {
  bool isGmail = false;
  Morepage({required this.isGmail, Key? key}) : super(key: key);

  @override
  _MorepageState createState() => _MorepageState();
}

class _MorepageState extends State<Morepage> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel? loggedInUser = UserModel();
  AuthService authService = AuthService();
  AuthFacebook authFacebook = AuthFacebook();

  String? ImageUrl;
  XFile? xfile;
  late File file;
  File? pickedImage;
  bool _isloading = false;
  @override
  void initState() {
    super.initState();
    _isloading = true;
    Future.delayed(Duration(seconds: 3),(){
      setState((){
        _isloading=false;
      });
    });

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
      body: _isloading ? Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      ):SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.isGmail
                ? Stack(
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
                    Column(
                      children: [
                        SizedBox(height: 20),
                        ProfileMenu(
                          text: "My Profile",
                          icon: "assets/icons/User Icon.svg",
                          press: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile_view(isGmail: false,))),
                          },
                        ),
                        ProfileMenu(
                          text: "About Us",
                          icon: "assets/icons/icon_about.svg",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => aboutus()));
                          },
                        ),
                        ProfileMenu(
                          text: "Log Out",
                          icon: "assets/icons/Log out.svg",
                          press: ()async {
                            final User? user = await firebaseAuth.currentUser;
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('No one has signed in.'),
                              ));
                              return;
                            }
                            logout(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginScreen()));
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
                    Column(
                      children: [
                        SizedBox(height: 20),
                        ProfileMenu(
                          text: "My Profile",
                          icon: "assets/icons/User Icon.svg",
                          press: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile_view(isGmail: false,))),
                          },
                        ),
                        ProfileMenu(
                          text: "About Us",
                          icon: "assets/icons/icon_about.svg",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewLoad()));
                          },
                        ),
                        ProfileMenu(
                          text: "Log Out",
                          icon: "assets/icons/Log out.svg",
                          press: ()async {
                            final User? user = await firebaseAuth.currentUser;
                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('No one has signed in.'),
                              ));
                              return;
                            }
                            logout(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LoginScreen()));
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
