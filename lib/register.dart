// import 'package:apptesting/landing_page.dart';
// import 'package:apptesting/morepage.dart';
// import 'package:apptesting/validator.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import 'fire.dart';
//
// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }
//
// class _RegisterPageState extends State<RegisterPage> {
//   final _registerFormKey = GlobalKey<FormState>();
//
//   final _nameTextController = TextEditingController();
//   final _emailTextController = TextEditingController();
//   final _passwordTextController = TextEditingController();
//
//   final _focusName = FocusNode();
//   final _focusEmail = FocusNode();
//   final _focusPassword = FocusNode();
//
//   bool _isProcessing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _focusName.unfocus();
//         _focusEmail.unfocus();
//         _focusPassword.unfocus();
//       },
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 0.0, right: 0.0),
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 30),
//               child: Column( mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:<Widget>[
//                   SizedBox(height: 70),
//                   Container(
//                     child: Text("SIGN UP",
//                       style: TextStyle(
//                         fontFamily: 'PoppinsSemiBold',
//                         color: Colors.black,
//                         fontSize: 30,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "Please fill the details and create account",
//                     style: TextStyle(
//                       fontFamily: 'PoppinsLight',
//                       fontSize: 16.5,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Form(
//                     key: _registerFormKey,
//                     child: Column(
//                       children: <Widget>[
//                         TextFormField(
//                           controller: _nameTextController,
//                           focusNode: _focusName,
//                           validator: (value) => Validator.validateName(
//                             name: value,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Enter Name",
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 )
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           controller: _emailTextController,
//                           focusNode: _focusEmail,
//                           validator: (value) => Validator.validateEmail(
//                             email: value,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Email",
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 )
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.0),
//                         TextFormField(
//                           controller: _passwordTextController,
//                           focusNode: _focusPassword,
//                           obscureText: true,
//                           validator: (value) => Validator.validatePassword(
//                             password: value,
//                           ),
//                           decoration: InputDecoration(
//                             hintText: "Password",
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 borderSide: BorderSide(
//                                   color: Colors.black,
//                                 )
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                               borderSide: BorderSide(
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 4.0),
//                         Text(
//                           "Password must be atleast 6 characters.",
//                           style: TextStyle(
//                             fontFamily: 'PoppinsItalic',
//                             fontSize: 12,
//                             color: Color(
//                               hexColor('8789A3'),),
//                           ),
//                           textAlign: TextAlign.left,
//                         ),
//                         SizedBox(height: 30),
//                         _isProcessing
//                             ? CircularProgressIndicator()
//                             : Center(
//                         ),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           elevation: 0,
//                           minWidth: double.maxFinite,
//                           height: 50,
//                           onPressed: () async {
//                             setState(() {
//                               _isProcessing = true;
//                             });
//
//                             if (_registerFormKey.currentState!
//                                 .validate()) {
//                               User? user = await FireAuth
//                                   .registerUsingEmailPassword(
//                                 name: _nameTextController.text,
//                                 email: _emailTextController.text,
//                                 password:
//                                 _passwordTextController.text,
//                               );
//
//                               setState(() {
//                                 _isProcessing = false;
//                               });
//
//                               if (user != null) {
//                                 Navigator.of(context)
//                                     .pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MorePage(user: user),
//                                   ),
//                                   ModalRoute.withName('/'),
//                                 );
//                               }
//                             }
//                           },
//                           child: Text('Sign Up',
//                               style: TextStyle(color: Colors.white,fontFamily: 'PoppinsMedium', fontSize: 16)),
//                           color: Color(
//                             hexColor('1183CA'),),
//                         ),
//                         SizedBox(height: 30),
//                         Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.black,
//                                   thickness: 0.5,
//                                   height: 50,
//                                 ),
//                               ),
//
//                               Text("   or   ",
//                                 style: TextStyle(
//                                   fontFamily: 'PoppinsRegular',
//                                   fontSize: 15,
//                                 ),
//                               ),
//
//                               Expanded(
//                                 child: Divider(
//                                   color: Colors.black,
//                                   thickness: 0.5,
//                                   height: 50,
//                                 ),
//                               ),
//                             ]
//                         ),
//                         SizedBox(height: 4), //space
//                         Center(
//                           child: Text(
//                             "Continue with",
//                             style: TextStyle(color: Color(
//                               hexColor('000000'),),fontFamily: 'PoppinsRegular', fontSize: 15),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           elevation: 0,
//                           minWidth: double.maxFinite,
//                           height: 50,
//                           onPressed: () {
//                             //Here goes the logic for Google SignIn discussed in the next section
//                           },
//                           color: Color(
//                             hexColor('EA4335'),),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 18,),
//                               SizedBox(width: 10),
//                               Text('Google',
//                                   style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           elevation: 0,
//                           minWidth: double.maxFinite,
//                           height: 50,
//                           onPressed: () {
//                             //Here goes the logic for Google SignIn discussed in the next section
//                           },
//                           color: Color(
//                             hexColor('3B5998'),),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 18,),
//                               SizedBox(width: 10),
//                               Text('Facebook',
//                                   style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 18),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("Already have an account? ",style: TextStyle(fontFamily: 'PoppinsExtraLight', fontSize: 15)),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//                               },
//                               child: Text(
//                                 "Log In",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   fontFamily: 'PoppinsMedium',
//                                   color: Color(
//                                     hexColor('1877F2'),),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// int hexColor(String color) {
//   //adding prefix
//   String newColor = '0xff' + color;
//   //removing # sign
//   newColor = newColor.replaceAll('#', '');
//   //converting it to the integer
//   int finalColor = int.parse(newColor);
//   return finalColor;
// }