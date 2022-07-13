import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'fetch_info.dart';


Widget fetchTamadunData(String collectionName) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(collectionName)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("info-items")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something is wrong"),
          );
        }

        return Material(
          child: ListView.builder(
            itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

              return Card(
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(
                        builder: (_) => FetchInfo())),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        NetworkImage(_documentSnapshot['info-img'][0]),
                      ),
                      title: Text(_documentSnapshot['info-title']),
                      subtitle: Text(
                        _documentSnapshot['info-sub'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection(collectionName)
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("info-items")
                                .doc(_documentSnapshot.id)
                                .delete();
                          },
                          icon:Icon(Icons.favorite,color: Colors.pink,)
                      ),
                    ),
                  )
              );
            },
          ),
        );
      });
}

class TamadunFavourite extends StatefulWidget {

  @override
  State<TamadunFavourite> createState() => _TamadunFavouriteState();
}

class _TamadunFavouriteState extends State<TamadunFavourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "User Favorite",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FetchInfo()));
          },
        ),
      ),
      body: SafeArea(
        child: fetchTamadunData("tamadun-users-favorites"),
      ),
    );
  }
}

