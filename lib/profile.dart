import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tamadun/profile_container.dart';

import 'auth/auth.dart';
import 'auth/google_auth.dart';
import 'authentication/log.dart';

//edit profile

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  DatabaseReference? userRef;

  File? pickedImage;
  bool showLocalFile = false;
  File? _profileImage;

  bool isLoading = false;
  String? displayName;
  String? bio;
  String? imagePickedType;

//profileImage klu tutup, part name dgn bio boleh tukar, klu profile tu ada sekali dia tak save
  /*displayProfileImage() {
    if (_profileImage == null) {
      if (loggedInUser.photoURL!.isEmpty) {
        return AssetImage('assets/images/placeholder');
      } else {
        return NetworkImage(loggedInUser.photoURL!);
      }
    } else {
      return FileImage(_profileImage!);
    }
  }*/
  //-----Picture Gallery

  /*pickImageFromGallery() async {

    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);

    if( img == null ) return;

    final tempImage = File(img.path);

    pickedImage = tempImage;
    showLocalFile = true;
    setState(() {

    });

    // upload to firebase storage


    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading !!!'),
      message: const Text('Please wait'),
    );
    progressDialog.show();
    try{
      var fileName = loggedInUser.email! + '.jpg';

      UploadTask uploadTask = FirebaseStorage.instance.ref('gs://my-project-78fd3.appspot.com').child('profile_images').child(fileName).putFile(pickedImage!);

      TaskSnapshot snapshot = await uploadTask;

      String profileImageUrl = await snapshot.ref.getDownloadURL();

      print(profileImageUrl);

      /*DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users').child(user.uid);
      await userRef.update({
        'photoURL' : profileImageUrl,
      });*/
      UserModel user = UserModel(

        photoURL: profileImageUrl,


      );
      DatabaseServices.updateUserData(user);
      Navigator.pop(context);

      progressDialog.dismiss();

    } catch( e ){
      progressDialog.dismiss();

      print(e.toString());
    }


  }*/

  /*pickImageFromCamera() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if( xFile == null ) return;

    final tempImage = File(xFile.path);

    pickedImage = tempImage;
    showLocalFile = true;
    setState(() {

    });

    //upload to database


  }*/

  //----------Save form ---------
//save form
  saveProfile() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && !isLoading) {
      setState(() {
        isLoading = true;
      });

      /*String profilePictureUrl = '';

      if (_profileImage == null) {
        profilePictureUrl = loggedInUser.photoURL!;
      } else {
        profilePictureUrl = await StorageService.uploadProfilePicture(
            loggedInUser.photoURL, _profileImage);
      }*/

      UserModel user = UserModel(
        uid: loggedInUser.uid,
        displayName: displayName,
        //photoURL: profilePictureUrl,
        bio: bio,
      );

      DatabaseServices.updateUserData(user);
      Navigator.pop(context);
    }
  }

  //gambar
  /*handleImageFromGallery() async {
    try {
      final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

      if (imageFile != null) {
        if (imagePickedType == 'profile') {
          setState(() {
            _profileImage = imageFile as File?;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }*/

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'MontserratBold',
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              // background image and bottom contents
              Expanded(
                  child: Column(children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 110, bottom: 10, right: 0, top: 10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgProfile.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  height: 240.0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "     ${loggedInUser.displayName ?? authService.getUserdisplayname()} \n     📧 ${loggedInUser.email ?? authService.getUserEmail()}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'PoppinsSemiBold',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //change username

                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(hexColor('F1F1F1')),
                            border: Border.all(
                              width: 1,
                              color: Color(
                                hexColor('A9A4A4'),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            initialValue: displayName,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              contentPadding: EdgeInsets.all(13),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                            validator: (input) => input!.trim().length < 2
                                ? 'please enter valid name'
                                : null,
                            onSaved: (value) {
                              displayName = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Color(hexColor('F1F1F1')),
                            border: Border.all(
                              width: 1,
                              color: Color(
                                hexColor('A9A4A4'),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            initialValue: bio,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Bio",
                              contentPadding: EdgeInsets.all(13),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                            onSaved: (value) {
                              bio = value;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightGreen),
                              )
                            : const SizedBox.shrink(),

                        //SizedBox(height: 15),
                        /*Container(

                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Color(
                                    hexColor('F1F1F1')),
                                border: Border.all(
                                  width: 1, color: Color(
                                  hexColor('A9A4A4'),
                                ),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "New Password",
                                  contentPadding: EdgeInsets.all(13),

                                ),

                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,


                              ),

                            ),*/

                        //SizedBox(height: 15),
                        /*Container(

                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Color(
                                    hexColor('F1F1F1')),
                                border: Border.all(
                                  width: 1, color: Color(
                                  hexColor('A9A4A4'),
                                ),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "New Password",
                                  contentPadding: EdgeInsets.all(13),
                                ),

                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,


                              ),

                            ),*/

                        SizedBox(height: 15),
                        /*Container(

                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Color(
                                    hexColor('F1F1F1')),
                                border: Border.all(
                                  width: 1, color: Color(
                                  hexColor('A9A4A4'),
                                ),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Confirm Password",
                                  contentPadding: EdgeInsets.all(13),
                                ),

                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,


                              ),

                            ),*/
                      ],
                    ),
                  ),
                ),

                //button Update
                SizedBox(height: 20),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: saveProfile,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Color(hexColor('a8fa87')),
                      border: Border.all(
                        width: 1,
                        color: Colors.lightGreenAccent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "Update Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ]))
            ]),
          ),
        ));
  }
}
