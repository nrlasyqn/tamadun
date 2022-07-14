import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:tamadun/screens/home_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userID;
var userDisplayName;
var userPicture;
var userEmail;
var isEmailVerified;
var userBio;
var userRole;

class AuthFacebook {
  Future<void> logInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: [
          'public_profile',
          'email',
        ],
      ); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        try {
          await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential);

          final User? user = _auth.currentUser;
          if (user != null) {
            User user = _auth.currentUser!;
            userID = user.uid;
            userDisplayName = user.displayName;
            userPicture = user.photoURL;
            userEmail = user.email;
            await updateTask(user);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> updateTask(User user) async {
    return await _firestore.collection('Users').doc(user.uid).set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now(),
        'bio': "hello there!",
        'role': "standard",
      },
    );
  }

  String getUserdisplayname() {
    return userDisplayName;
  }

  String getUserPicture() {
    return userPicture;
  }

  String getUserEmail() {
    return userEmail;
  }

  String getUserBio() {
    return userBio;
  }

  String getUserRole() {
    return userRole;
  }

  String isUserApproved() {
    if (isEmailVerified == false) {
      return 'Your email verification is pending';
    } else {
      return 'Your email is verified';
    }
  }
}
