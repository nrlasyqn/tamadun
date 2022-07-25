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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constant.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: mMorePageColor,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: mMorePageColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text,style: TextStyle(
              fontFamily: 'PoppinsRegular',
              fontSize: 18,
            ),)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}