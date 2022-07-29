import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tamadun/authentication/log.dart';
import 'package:tamadun/authentication/reg.dart';
import 'package:tamadun/screens/home_page.dart';
import 'package:tamadun/widget/profile_widget.dart';

import '../auth/facebook_auth.dart';
import '../auth/google_auth.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  var newPassword = " ";
  final newpasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    newpasswordController.dispose();
    super.dispose();
  }


  changePassword() async {
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen())
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text("Your password has been changed! Login again"),
      ),);
    }catch(error){

    }
  }
  // firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  // string for displaying the error Message
  String? errorMessage;

  AuthService authService = AuthService();
  AuthFacebook authFacebook = AuthFacebook();

  //var loading = false;

  // void _logInWithFacebook() async {
  //   setState(() {loading = true;});
  //
  //   try{
  //     final facebookLoginResult = await FacebookAuth.instance.login();
  //     final userData = await FacebookAuth.instance.getUserData();
  //
  //     final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
  //     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //
  //     await FirebaseFirestore.instance.collection('Users').add({
  //       'email': userData['email'],
  //       'imageUrl': userData['picture']['data']['url'],
  //       'name': userData['name'],
  //       'uid' : userData['uid'],
  //     });
  //
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => HomePage(),
  //       ),
  //           (route) => false,
  //     );
  //   } on Exception catch (e) {
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {

    //password field
    // final passwordField = TextFormField(
    //     autofocus: false,
    //     controller: newpasswordController,
    //     obscureText: true,
    //     validator: (value) {
    //       RegExp regex = new RegExp(r'^.{6,}$');
    //       if (value!.isEmpty) {
    //         return ("Password is required for login");
    //       }
    //       if (!regex.hasMatch(value)) {
    //         return ("Enter Valid Password(Min. 6 Character)");
    //       }
    //     },
    //     onSaved: (value) {
    //       newpasswordController.text = value!;
    //     },
    //     textInputAction: TextInputAction.done,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(Icons.vpn_key),
    //       contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       hintText: "Enter Password",
    //       border: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(10),
    //         borderSide: BorderSide(color: Colors.black),
    //       ),
    //     ));


    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Update Password',
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 70),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            child: TextFormField(
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3, color: Colors.red),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: 'New Password',
                                hintText: 'Enter New Password',
                                border: OutlineInputBorder(),
                              ),
                              controller: newpasswordController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                            ),
                          ),
                        // ElevatedButton(onPressed: () {
                        //   if(_formKey.currentState!.validate()){
                        //     setState(() {
                        //       newPassword = newpasswordController.text;
                        //     });
                        //     changePassword();
                        //   }
                        // },
                        //     child: Text("Change Password")),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              ProfileWidget(
                                text: "Change Password",
                                press: () {
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      newPassword = newpasswordController.text;
                                    });
                                    changePassword();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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
