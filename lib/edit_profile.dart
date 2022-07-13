import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late final Stream<QuerySnapshot> _mainStream = FirebaseFirestore.instance
      .collection('sub_title')
      .doc("123")
      .collection('bteou')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _mainStream,
      builder: (context, mainSnapshot) {
        if (mainSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        if (mainSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var pendenciesList = mainSnapshot.data!.docs;
        print(pendenciesList);

        return SafeArea(
          child: SizedBox(
            width: mediaQuery.width,
            height: mediaQuery.height,
            child: const Center(
                child: Text('Test')
            ),
          ),
        );
      },
    );

  }
}