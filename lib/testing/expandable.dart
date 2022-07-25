// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Hide the debug banner
//         debugShowCheckedModeBanner: false,
//         title: 'KindaCode.com',
//         theme: ThemeData(primarySwatch: Colors.green),
//         home: const HomeScreen());
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('KindaCode.com')),
//       // Implement the ExpansionTile
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const ExpansionTile(
//               title: Text('Colors'),
//               subtitle: Text('Expand this tile to see its contents'),
//               // Contents
//               children: [
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                     ),
//                     title: Text('Blue')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.red,
//                     ),
//                     title: Text('Red')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.amber,
//                     ),
//                     title: Text('Amber')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink,
//                     ),
//                     title: Text('Pink')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.green,
//                     ),
//                     title: Text('Green')),
//               ],
//             ),
//             ExpansionTile(
//               title: Text('Colors'),
//               subtitle: Text('Expand this tile to see its contents'),
//               // Contents
//               children: [
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blue,
//                     ),
//                     title: Text('Blue')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.red,
//                     ),
//                     title: Text('Red')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.amber,
//                     ),
//                     title: Text('Amber')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pink,
//                     ),
//                     title: Text('Pink')),
//                 ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.green,
//                     ),
//                     title: Text('Green')),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }