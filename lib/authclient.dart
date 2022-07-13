// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// var uid;
// var name;
// var email;
// var imageUrl;
//
// Future<String?> signInWithGoogle() async {
//   await Firebase.initializeApp();
//
//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication? googleSignInAuthentication =
//   await googleSignInAccount?.authentication;
//
//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication?.accessToken,
//     idToken: googleSignInAuthentication?.idToken,
//   );
//
//   final UserCredential authResult =
//   await _auth.signInWithCredential(credential);
//   final User? loggedInUser = authResult.user;
//
//   if (loggedInUser != null) {
//     // Checking if email and name is null
//     assert(loggedInUser.uid != null);
//     assert(loggedInUser.email != null);
//     assert(loggedInUser.displayName != null);
//     assert(loggedInUser.photoURL != null);
//
//     uid = loggedInUser.uid;
//     name = loggedInUser.displayName;
//     email = loggedInUser.email;
//     imageUrl = loggedInUser.photoURL;
//
//     assert(!loggedInUser.isAnonymous);
//     assert(await loggedInUser.getIdToken() != null);
//
//     return 'Google sign in successful, User UID: ${loggedInUser.uid}';
//
//   }
//
//   return null;
// }
//
// Future<void> signOutGoogle() async {
//   await googleSignIn.signOut();
//
//   print("User Signed Out");
// }