import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamadun/screens/home_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var userID;
var userDisplayName;
var userPicture;
var userEmail;
var isEmailVerified;
var userBio;
var userRole;

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? _googleSignInAuthentication =
          await _googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication?.idToken,
        accessToken: _googleSignInAuthentication?.accessToken,
      );

      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        User user = await _firebaseAuth.currentUser!;

        userID = user.uid;
        userDisplayName = user.displayName;
        userPicture = user.photoURL;
        userEmail = user.email;

        updateTask(user);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();

    print("User Signed Out");
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
