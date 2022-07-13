
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tamadun/authentication/reg.dart';

import '../auth/facebook_auth.dart';
import '../authclient.dart';
import '../fire.dart';
import '../auth/google_auth.dart';
import '../screens/mainbody.dart';
import 'resetpassword.dart';
import '../screens/user_profile_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

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
  //         builder: (BuildContext context) => mainbody(),
  //       ),
  //           (route) => false,
  //     );
  //   } on Exception catch (e) {
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        minWidth: double.maxFinite,
        height: 50,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: Text('Log In',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'PoppinsMedium',
                fontSize: 16)),
        color: Color(
          hexColor('1183CA'),
        ),
      ),
    );

    return Scaffold(
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
                    Container(
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Text(
                      "Please login to continue using our app",
                      style: TextStyle(
                        fontFamily: 'PoppinsLight',
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.left,
                    ),
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
                          emailField,
                          SizedBox(height: 10),
                          passwordField,
                          SizedBox(height: 30),
                          loginButton,
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPage()));
                                },
                                child: Text(
                                  "Forgot your password ?",
                                  style: TextStyle(color: Color(
                                    hexColor('8789A3'),),fontFamily: 'PoppinsRegular', fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.5,
                                    height: 50,
                                  ),
                                ),

                                Text("   or   ",
                                  style: TextStyle(
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 15,
                                  ),
                                ),

                                Expanded(
                                  child: Divider(
                                    color: Colors.black,
                                    thickness: 0.5,
                                    height: 50,
                                  ),
                                ),
                              ]
                          ),
                          SizedBox(height: 4), //space
                          Center(
                            child: Text(
                              "Continue with",
                              style: TextStyle(color: Color(
                                hexColor('000000'),),fontFamily: 'PoppinsRegular', fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                            minWidth: double.maxFinite,
                            height: 50,
                            onPressed: () {
                              authService.signInWithGoogle(context);
                            },
                            color: Color(
                              hexColor('EA4335'),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 18,),
                                SizedBox(width: 10),
                                Text('Google',
                                    style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                            minWidth: double.maxFinite,
                            height: 50,
                            onPressed: () {
                              authFacebook.logInWithFacebook(context);
                              //     if (_formKey.currentState!.validate()) {
                              //       try {
                              //         setState(() {});
                              //         await Provider.of<AppUser>(context,
                              //             listen: false)
                              //             .signIn(
                              //             email: emailController.text.trim(),
                              //             password: emailController.text);
                              //         Navigator.pushReplacement(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                  mainbody()));
                              //       } catch (e) {
                              //         setState(() {});
                              //         ScaffoldMessenger.of(context).showSnackBar(
                              //           SnackBar(
                              //               content: Text(
                              //                   e.toString().split(']').last)),
                              //         );
                              //       }
                              //     }
                              //   //Here goes the logic for Google SignIn discussed in the next section
                            },
                            color: Color(
                              hexColor('3B5998'),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 18,),
                                SizedBox(width: 10),
                                Text('Facebook',
                                    style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(height: 18),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account? ",style: TextStyle(fontFamily: 'PoppinsExtraLight', fontSize: 15)),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegistrationScreen()));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'PoppinsMedium',
                                      color: Color(
                                        hexColor('1877F2'),),
                                    ),
                                  ),
                                )
                              ])
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

  // login function
  Future<User?> signIn(String email, String password) async {

    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => mainbody())),
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }

    return user;
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