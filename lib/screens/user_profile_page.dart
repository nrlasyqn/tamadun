import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamadun/auth/facebook_auth.dart';
import 'package:tamadun/widget/profile_widget.dart';
import 'package:tamadun/widget/profilemenu_more.dart';
import '../auth/auth.dart';
import '../auth/google_auth.dart';
import '../authentication/log.dart';
import '../screens/aboutus.dart';
import '../screens/home_page.dart';
import '../screens/more_page.dart';
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
  bool _isloading = false;

  @override
  void initState() {
    _isloading = true;
    Future.delayed(const Duration(seconds: 5),(){
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: "MontserratBold",
            fontSize: 24,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));*/
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Morepage(isGmail: false,))); 
            });
          },
        ),
      ),
      body: _isloading ? Center(
        child: CircularProgressIndicator(
          color: Color(hexColor('#25346a')),
        ),
      ):SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.isGmail
                ?  Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Container(
                  height: screen.height,
                  width: screen.width,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Color(hexColor("BF#495885")),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: pickedImage == null
                                ? NetworkImage(loggedInUser?.photoURL! == ''
                                ? 'https://www.seekpng.com/png/full/41-410093_circled-user-icon-user-profile-icon-png.png'
                                : loggedInUser!.photoURL!)
                                : FileImage(pickedImage!) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screen.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("${loggedInUser!.displayName ?? authService.getUserdisplayname()}", style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsRegular',
                          fontSize: 18,
                        ),),
                      ),
                    ),
                    Container(
                      height: screen.height/5.0,
                      width: screen.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("${loggedInUser!.role ?? authService.getUserRole()}", style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsItalic',
                          fontSize: 16,
                        ),),
                      ),
                    ),
                    const SizedBox(height:20.0),
                    Container(
                        height: screen.height/10.0,
                        width: screen.width,
                        child : Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                child: Text(" Email Address",style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16,
                                ),),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                child: Container(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: screen.width,
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
                                      "${loggedInUser!.email ?? authService.getUserEmail()}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                    ),

                    const SizedBox(height: 15,),
                    Container(
                        height: screen.height/10.0,
                        width: screen.width,
                        child : Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                child: Text(" Bio",style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16,
                                ),),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                child: Container(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: screen.width,
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
                                      "${loggedInUser!.bio ?? authService.getUserBio()}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                            ),

                          ],
                        )
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      width: screen.width * 0.91,
                      child: ElevatedButton(
                          child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child:  Text('Edit Profile',style: TextStyle(
                                fontFamily: 'PoppinsRegular',
                                fontSize: 18,
                                color: Colors.white,))
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10),
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          }
                      ),
                    ),
                  ]),
                ),

              ],
            )
                : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // background image and bottom contents
                Container(
                  height: screen.height,
                  width: screen.width,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: CircleAvatar(
                          radius: 85,
                          backgroundColor: Color(hexColor("BF#495885")),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundImage: pickedImage == null
                                ? NetworkImage(loggedInUser?.photoURL! == ''
                                ? 'https://www.seekpng.com/png/full/41-410093_circled-user-icon-user-profile-icon-png.png'
                                : loggedInUser!.photoURL!)
                                : FileImage(pickedImage!) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.displayName ?? authFacebook.getUserdisplayname()}", style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("${loggedInUser!.role ?? authFacebook.getUserRole()}", style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsItalic',
                        fontSize: 16,
                      ),),
                    ),
                    const SizedBox(height:20.0),
                    Container(
                        width: screen.width,
                        child : Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                child: Text(" Email Address",style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16,
                                ),),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                child: Container(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: screen.width,
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
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                            ),
                          ],
                        )
                    ),

                    const SizedBox(height: 15,),
                    Container(
                        width: screen.width,
                        child : Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                child: Text(" Bio",style: TextStyle(
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16,
                                ),),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                                child: Container(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: screen.width,
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
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                            ),

                          ],
                        )
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Container(
                        height: 50,
                        width: screen.width,
                        child: ElevatedButton(
                            child: const Text('Edit Profile',style: TextStyle(
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18,
                              color: Colors.white,)),
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(10),
                                    )
                                )
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            }
                        ),
                      ),
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
        return const LoginScreen();
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