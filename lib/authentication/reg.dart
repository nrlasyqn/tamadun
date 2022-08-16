import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tamadun/screens/home_page.dart';

import '../auth/auth.dart';
import '../auth/facebook_auth.dart';
import '../auth/google_auth.dart';
import 'log.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  var loading = false;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final NameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  AuthService authService = AuthService();
  AuthFacebook authFacebook = AuthFacebook();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: NameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
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
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email Address",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          NameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
        ));

    //signup button
    final signUpButton = Material(
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
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text('Sign Up',
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
                        "SIGN UP",
                        style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Text(
                      "Please fill the details and create account",
                      style: TextStyle(
                        fontFamily: 'PoppinsLight',
                        fontSize: 16.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          firstNameField,
                          SizedBox(height: 10),
                          emailField,
                          SizedBox(height: 10),
                          passwordField,
                          SizedBox(height: 10),
                          confirmPasswordField,
                          SizedBox(height: 30),
                          signUpButton,
                          SizedBox(height: 30),
                          Row(children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                thickness: 0.5,
                                height: 50,
                              ),
                            ),
                            Text(
                              "   or   ",
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
                          ]),
                          SizedBox(height: 4), //space
                          Center(
                            child: Text(
                              "Continue with",
                              style: TextStyle(
                                  color: Color(
                                    hexColor('000000'),
                                  ),
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 15),
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
                              //Here goes the logic for Google SignIn discussed in the next section
                              authService.signInWithGoogle(context);
                            },
                            color: Color(
                              hexColor('EA4335'),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Text('Google',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'PoppinsSemiBold',
                                        fontSize: 15)),
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
                              //Here goes the logic for Google SignIn discussed in the next section
                              authFacebook.logInWithFacebook(context);
                            },
                            color: Color(
                              hexColor('3B5998'),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 10),
                                Text('Facebook',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'PoppinsSemiBold',
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account? ",
                                  style: TextStyle(
                                      fontFamily: 'PoppinsExtraLight',
                                      fontSize: 15)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'PoppinsMedium',
                                    color: Color(
                                      hexColor('1877F2'),
                                    ),
                                  ),
                                ),
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.displayName = NameEditingController.text;

    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
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
