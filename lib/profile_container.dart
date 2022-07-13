
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth/auth.dart';

class DatabaseServices {

  static void updateUserData(UserModel user) {
    FirebaseFirestore.instance
        .collection("Users").doc(user.uid).update({
      'displayName': user.displayName,
      'bio': user.bio,
      //'photoURL': user.photoURL,
      'lastSeen': DateTime.now(),
    });
  }



}