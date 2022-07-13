// import 'package:apptesting/login.dart';
// import 'package:apptesting/main.dart';
// import 'package:apptesting/mainpage.dart';
// import 'package:flutter/material.dart';
// import 'package:apptesting/constant.dart';
//
// class ExploreButtonTest extends StatefulWidget {
//
//   @override
//   State<ExploreButtonTest> createState() => _ExploreButtonState();
// }
//
// class _ExploreButtonState extends State<ExploreButtonTest> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//
//       body: SingleChildScrollView(
//         child: Container(
//           //todo : Explore button position
//           padding: EdgeInsets.fromLTRB(260, 500, 0, 0),
//           alignment: Alignment.bottomCenter,
//           child: Column(
//             children: [
//               RaisedButton(
//                 onPressed: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//                 },
//                 color: mPrimaryColor,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(32))
//                 ),
//                 child: Container(
//                   width: 85,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Text(
//                     'Explore',
//                     style: TextStyle(
//                         color: Colors.indigo.shade900,
//                         fontSize: 20,
//                         fontFamily: 'MontserratBold'
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }