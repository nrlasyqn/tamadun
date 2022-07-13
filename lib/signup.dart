// import 'package:apptesting/searchpage.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'auth_controller.dart';
// import 'login.dart';
// import 'main.dart';
//
// void main() => runApp(MaterialApp(home: Signup(),
// ));
//
// class Signup extends StatelessWidget {
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 30),
//           child: Column( mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:  <Widget>[
//               SizedBox(height: 70),
//               Container(
//                 child: Text("SIGN UP",
//                   style: TextStyle(
//                     fontFamily: 'PoppinsSemiBold',
//                     color: Colors.black,
//                     fontSize: 30,
//                   ),
//                 ),
//               ),
//               Text(
//                 "Please fill the details and create account",
//                 style: TextStyle(
//                   fontFamily: 'PoppinsLight',
//                   fontSize: 17,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               _buildTextField(
//                   nameController, 'Name'),
//               SizedBox(
//                 height: 10,
//               ),
//               _buildTextField(
//                   emailController, 'Email Address'),
//               SizedBox(
//                 height: 10,
//               ),
//               _buildTextField(
//                   passwordController, 'Password'),
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 "Password must be atleast 6 characters.",
//                 style: TextStyle(
//                   fontFamily: 'PoppinsItalic',
//                   fontSize: 12,
//                   color: Color(
//                     hexColor('8789A3'),),
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//               SizedBox(height: 30),
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 elevation: 0,
//                 minWidth: double.maxFinite,
//                 height: 50,
//                 onPressed: () {
//                   //AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
//                 },
//                 child: Text('Sign Up',
//                     style: TextStyle(color: Colors.white,fontFamily: 'PoppinsMedium', fontSize: 16)),
//                 color: Color(
//                   hexColor('1183CA'),),
//               ),
//               SizedBox(height: 10), //space
//               Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Divider(
//                         color: Colors.black,
//                         thickness: 0.5,
//                         height: 50,
//                       ),
//                     ),
//
//                     Text("   or   ",
//                       style: TextStyle(
//                         fontFamily: 'PoppinsRegular',
//                         fontSize: 15,
//                       ),
//                     ),
//
//                     Expanded(
//                       child: Divider(
//                         color: Colors.black,
//                         thickness: 0.5,
//                         height: 50,
//                       ),
//                     ),
//                   ]
//               ),
//               SizedBox(height: 4), //space
//               Center(
//                 child: Text(
//                   "Continue with",
//                   style: TextStyle(color: Color(
//                     hexColor('000000'),),fontFamily: 'PoppinsRegular', fontSize: 15),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 20),
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 elevation: 0,
//                 minWidth: double.maxFinite,
//                 height: 50,
//                 onPressed: () {
//                   //Here goes the logic for Google SignIn discussed in the next section
//                 },
//                 color: Color(
//                   hexColor('EA4335'),),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 18,),
//                     SizedBox(width: 10),
//                     Text('Google',
//                         style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 elevation: 0,
//                 minWidth: double.maxFinite,
//                 height: 50,
//                 onPressed: () {
//                   //Here goes the logic for Google SignIn discussed in the next section
//                 },
//                 color: Color(
//                   hexColor('3B5998'),),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 18,),
//                     SizedBox(width: 10),
//                     Text('Facebook',
//                         style: TextStyle(color: Colors.white,fontFamily: 'PoppinsSemiBold', fontSize: 15)),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 18),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Already have an account? ",style: TextStyle(fontFamily: 'PoppinsExtraLight', fontSize: 15)),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//                     },
//                     child: Text(
//                       "Log In",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontFamily: 'PoppinsMedium',
//                         color: Color(
//                           hexColor('1877F2'),),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],),
//         ),
//       ),
//     );
//   }
//   buildIcon( TextEditingController controller, IconData icon, String labelText){
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           border: Border.all(color: Colors.black)
//       ),
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal:0),
//           labelText: labelText,
//           labelStyle: TextStyle(
//             height: 50,
//             fontFamily: 'PoppinsLight',
//             fontSize: 15,
//           ),
//           icon: Icon(
//             icon,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
//
//   _buildTextField(TextEditingController controller, String labelText){
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           border: Border.all(color: Colors.black)
//       ),
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 14),
//           labelText: labelText,
//           labelStyle: TextStyle(
//             height: 50,
//             fontFamily: 'PoppinsLight',
//             fontSize: 15,
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
