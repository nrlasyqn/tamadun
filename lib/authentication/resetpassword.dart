
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../auth/validator.dart';
import 'log.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();

  final _focusEmail = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
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
                              "Forgot Password",
                              style: TextStyle(
                                fontFamily: 'PoppinsSemiBold',
                                color: Colors.black,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          Text(
                            "Enter your email and we will send you a password reset link",
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
                              children: <Widget>[
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Enter Email Address",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        )),
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0,
                                  minWidth: double.maxFinite,
                                  height: 50,
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _emailTextController.text)
                                        .then((value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    });
                                  },
                                  child: Text('Reset Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsMedium',
                                          fontSize: 16)),
                                  color: Color(
                                    hexColor('1183CA'),
                                  ),
                                ),
                                _isProcessing
                                    ? CircularProgressIndicator()
                                    : Center(),
                                SizedBox(height: 20.0),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0,
                                  minWidth: double.maxFinite,
                                  height: 50,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text('Back',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsMedium',
                                          fontSize: 16)),
                                  color: Color(
                                    hexColor('1183CA'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
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
