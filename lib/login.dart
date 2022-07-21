import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamadun/auth/auth.dart';

class LoginController with ChangeNotifier {
  // object
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserModel? userModel;

  // fucntion for google login

  // function for facebook login
  facebookLogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );
    // check the status of our login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );
      userModel = UserModel(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"] ?? " ",
      );
      notifyListeners();
    }
  }

  // logout
  logout() async {
    googleSignInAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userModel = null;
    notifyListeners();
  }
}
