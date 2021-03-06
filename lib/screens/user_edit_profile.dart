import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:ndialog/ndialog.dart';
import 'package:tamadun/testing/text.dart';
import '../auth/auth.dart';
import '../auth/database_service.dart';
import '../auth/google_auth.dart';
import '../change_pass.dart';
import '../widget/constant.dart';

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

  File? pickedImage;

  bool isLoading = false;

  String? displayName;
  String? bio;
  String? imagePickedType;
  String? photoImageURL;

  //images

  void getFromGallery() async {
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.gallery);
    pickedImage = File(pic!.path);
    updateImage();
  }

  void getFromCamera() async {
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
    pickedImage = File(pic!.path);
    updateImage();
  }

  void updateImage() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading...'),
      message: const Text('Please Wait!'),
    );
    progressDialog.show();
    try {
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profileImage').child(filename);
      UploadTask uploadTask = storageRef.putFile(File(pickedImage!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url) async {
        photoImageURL = url;
      });
      progressDialog.dismiss();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user!.uid)
          .update({
        'photoURL': photoImageURL,
      });

      progressDialog.dismiss();
    } catch (e) {
      progressDialog.dismiss();
      print(e.toString());
    }
  }

  //----------Save form ---------
//save form

  saveProfile() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate() && !isLoading) {
      setState(() {
        isLoading = true;
      });

      UserModel user = UserModel(
        uid: loggedInUser.uid,
        displayName: displayName,
        //photoURL: url,
        bio: bio,
      );

      DatabaseServices.updateUserData(user);
      Navigator.pop(context);
    }
  }

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
        title: Text(
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
          child: Column(
            children: <Widget>[
              // background image and bottom contents
              Center(
                child: Column(
                  /*crossAxisAlignment: CrossAxisAlignment.start,*/
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 85,
                            backgroundColor: mMorePageColor,
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: pickedImage == null
                                  ? NetworkImage(loggedInUser.photoURL! == ''
                                      ? 'https://freesvg.org/img/abstract-user-flat-4.png'
                                      : loggedInUser.photoURL!)
                                  : FileImage(pickedImage!) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 130,
                          left: 97,
                          child: RawMaterialButton(
                            elevation: 3,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.blueAccent,
                            ),
                            padding: EdgeInsets.all(15),
                            shape: CircleBorder(),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.image),
                                              title: const Text('Gallery'),
                                              onTap: () {
                                                getFromGallery();
                                              },
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.camera_alt),
                                              title: const Text('Camera'),
                                              onTap: () {
                                                getFromCamera();
                                              },
                                            ),
                                          ]),
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //change image

              //change username, email, bio
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${loggedInUser.displayName ?? authService.getUserdisplayname()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 18,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${loggedInUser.role ?? authService.getUserRole()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PoppinsItalic',
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Color(hexColor('FFF5F6F9')),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Name",
                            contentPadding: EdgeInsets.all(13),
                          ),
                          style: TextStyle(
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
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Color(hexColor('FFF5F6F9')),
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Bio",
                            contentPadding: EdgeInsets.all(13),
                          ),
                          style: TextStyle(
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
                      SizedBox(height: 15),
                      isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.lightGreen),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),

              //button Update and password
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ProfileWidget(
                    text: "Save",
                    press: saveProfile,
                  ),
                  ProfileWidget(
                    text: "Change Password",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePass()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// the logout function
/*Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
}*/

int hexColor(String color) {
  //adding prefix
  String newColor = '0xff' + color;
  //removing # sign
  newColor = newColor.replaceAll('#', '');
  //converting it to the integer
  int finalColor = int.parse(newColor);
  return finalColor;
}
