// // // import 'package:firebase_auth/firebase_auth.dart';
// // //
// // // class FireAuth {
// // //   // For sign up a new user
// // //   static Future<User?> registerUsingEmailPassword({
// // //     required String name,
// // //     required String email,
// // //     required String password,
// // //   }) async {
// // //     FirebaseAuth auth = FirebaseAuth.instance;
// // //     User? user;
// // //
// // //     try {
// // //       UserCredential userCredential = await auth.createUserWithEmailAndPassword(
// // //         email: email,
// // //         password: password,
// // //       );
// // //
// // //       user = userCredential.user;
// // //       await user!.updateProfile(displayName: name);
// // //       await user.reload();
// // //       user = auth.currentUser;
// // //     } on FirebaseAuthException catch (e) {
// // //       if (e.code == 'weak-password') {
// // //         print('The password provided is too weak.');
// // //       } else if (e.code == 'email-already-in-use') {
// // //         print('The account already exists for that email.');
// // //       }
// // //     } catch (e) {
// // //       print(e);
// // //     }
// // //
// // //     return user;
// // //   }
// // //
// // //   // For log in an user (have already registered)
// // //   static Future<User?> signInUsingEmailPassword({
// // //     required String email,
// // //     required String password,
// // //   }) async {
// // //     FirebaseAuth auth = FirebaseAuth.instance;
// // //     User? user;
// // //
// // //     try {
// // //       UserCredential userCredential = await auth.signInWithEmailAndPassword(
// // //         email: email,
// // //         password: password,
// // //       );
// // //       user = userCredential.user;
// // //     } on FirebaseAuthException catch (e) {
// // //       if (e.code == 'user-not-found') {
// // //         print('No user found for that email.');
// // //       } else if (e.code == 'wrong-password') {
// // //         print('Wrong password provided.');
// // //       }
// // //     }
// // //
// // //     return user;
// // //   }
// // //
// // //   // reset pass
// // //
// // //   //for refresh the user
// // //   static Future<User?> refreshUser(User user) async {
// // //     FirebaseAuth auth = FirebaseAuth.instance;
// // //
// // //     await user.reload();
// // //     User? refreshedUser = auth.currentUser;
// // //
// // //     return refreshedUser;
// // //   }
// // //
// // // }
// //
// // import 'package:apptesting/user_details.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// //
// // class LoginController with ChangeNotifier {
// //   // object
// //   var _googleSignIn = GoogleSignIn();
// //   GoogleSignInAccount? googleSignInAccount;
// //   UserDetails? userDetails;
// //
// //
// //   // function for facebook login
// //   facebooklogin() async {
// //     var result = await FacebookAuth.i.login(
// //       permissions: ["public_profile", "email"],
// //     );
// //
// //     // check the status of our login
// //     if (result.status == LoginStatus.success) {
// //       final requestData = await FacebookAuth.i.getUserData(
// //         fields: "email, name, picture",
// //       );
// //
// //       this.userDetails = new UserDetails(
// //         displayName: requestData["name"],
// //         email: requestData["email"],
// //         photoURL: requestData["picture"]["data"]["url"] ?? " ",
// //       );
// //       notifyListeners();
// //     }
// //   }
// //
// //   // logout
// //
// //   logout() async {
// //     this.googleSignInAccount = await _googleSignIn.signOut();
// //     await FacebookAuth.i.logOut();
// //     userDetails = null;
// //     notifyListeners();
// //   }
// // }
//
// import 'package:apptesting/mainbody.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
//
// class AppUser extends ChangeNotifier {
//   String? name;
//
//   AppUser._() {
//     FirebaseAuth.instance.authStateChanges().listen((user) {
//       notifyListeners();
//     });
//   }
//
//   User? get user => FirebaseAuth.instance.currentUser;
//
//   factory AppUser() => AppUser._();
//   String role = 'None';
//
//   static AppUser get instance => AppUser();
//
//
//   Future<void> signIn({required String email, required String password}) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       print('Sign in Successful');
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw ('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         throw ('Wrong password provided for that user.');
//       } else {
//         throw (e.toString());
//       }
//     }
//   }
//
//   Future<bool> signUp({
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     try {
//       await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       await AppUser.instance.user!.updateDisplayName(name);
//       return true;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<void> updateName(String text) async {
//     await AppUser.instance.user!.updateDisplayName(text);
//     getName();
//     notifyListeners();
//   }
//
//   Future<void> loginFB(context) async {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: [
//         'public_profile',
//         'email',
//       ],
//     ); // by default we request the email and the public profile
// // or FacebookAuth.i.login()
//     if (result.status == LoginStatus.success) {
//       final OAuthCredential facebookAuthCredential =
//       FacebookAuthProvider.credential(result.accessToken!.token);
//
//       try {
//         await FirebaseAuth.instance
//             .signInWithCredential(facebookAuthCredential);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => HomePage()));
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(e.message!)));
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(result.message.toString())));
//     }
//   }
//
//   void getName() {
//     name = AppUser.instance.user!.displayName ?? 'No Data';
//   }
//
//   loginGoogle(BuildContext context) async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth!.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       try {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => HomePage()));
//       } on FirebaseAuthException catch (e) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(e.message!)));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(e.toString())));
//     }
//   }
// }
