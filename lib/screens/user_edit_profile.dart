import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:ndialog/ndialog.dart';
import 'package:tamadun/widget/profile_widget.dart';
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
        displayName: displayName ?? "Anonymous",
        //photoURL: url,
        bio: bio ?? 'Hello There!',
      );

      DatabaseServices.updateUserData(user);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });

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
    // TextEditingController bioUser = TextEditingController();
    // TextEditingController nameUser = TextEditingController();
    // bioUser.text = "${loggedInUser.bio}";
    // nameUser.text = "${loggedInUser.displayName}";
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: const TextStyle(
            fontFamily: "MontserratBold",
            fontSize: 24,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(hexColor('#25346a')),
        ),
      )
          : SafeArea(
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
                            backgroundColor: Color(hexColor("BF#495885")),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: pickedImage == null
                                  ? NetworkImage(loggedInUser.photoURL! ==
                                  ''
                                  ? 'https://www.seekpng.com/png/full/41-410093_circled-user-icon-user-profile-icon-png.png'
                                  : loggedInUser.photoURL!)
                                  : FileImage(pickedImage!)
                              as ImageProvider,
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
                              color: Color(hexColor("#495885")),
                            ),
                            padding: const EdgeInsets.all(15),
                            shape: const CircleBorder(),
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
                                              leading:
                                              const Icon(Icons.image),
                                              title:
                                              const Text('Gallery'),
                                              onTap: () {
                                                getFromGallery();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.camera_alt),
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
                  style: const TextStyle(
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
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'PoppinsItalic',
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: double.maxFinite,
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
                            //controller: nameUser,
                            initialValue:"${loggedInUser.displayName ?? authService.getUserdisplayname()}",
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              contentPadding: EdgeInsets.all(5),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                            validator: (input){
                              if(input !.trim().length <3|| input.isEmpty || input == null){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 5),
                                      content: Text('Please Enter Valid Name(Min. 3 Character)!'),
                                    ),
                                );
                                 //Fluttertoast.showToast(msg: 'Please Enter Valid Name!');
                              }
                              return null;
                            },
                            // validator: (input) => input!.trim().length < 3
                            //     ? 'please enter valid name'
                            //     : null,
                            onSaved: (value) {
                              displayName = value ?? "Anonymous";
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 50,
                          width: double.maxFinite,
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
                            //controller: bioUser,
                            initialValue: "${loggedInUser.bio ?? authService.getUserBio()}",
                            decoration: const InputDecoration(
                              // suffixIcon: IconButton(
                              //   onPressed: saveBio(),
                              //   icon: Icon(Icons.check_circle_outline),
                              // ),
                              border: InputBorder.none,
                              hintText: "Bio",
                              contentPadding: EdgeInsets.all(5),
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
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(15),
                      //     height: 50,
                      //     width: double.maxFinite,
                      //     decoration: BoxDecoration(
                      //       color: Color(hexColor('FFF5F6F9')),
                      //       border: Border.all(
                      //         width: 1,
                      //         color: Color(
                      //           hexColor('A9A4A4'),
                      //         ),
                      //       ),
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //     child: TextFormField(
                      //       initialValue: bio,
                      //       decoration: const InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "Bio",
                      //         contentPadding: EdgeInsets.all(13),
                      //       ),
                      //       style: const TextStyle(
                      //         color: Colors.black,
                      //         fontFamily: 'PoppinsRegular',
                      //         fontSize: 18,
                      //       ),
                      //       textAlign: TextAlign.left,
                      //       onSaved: (value) {
                      //         bio = value;
                      //       },
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                      isLoading
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(hexColor('#25346a'))),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),

              //button Update and password
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          child: const Text('Save Profile',style: const TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                            color: Colors.white,)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10),
                                  )
                              )
                          ),
                          onPressed: saveProfile,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          child: const Text('Change Password',style: TextStyle(
                            fontFamily: 'PoppinsRegular',
                            fontSize: 18,
                            color: Colors.white,)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF495885)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10),
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChangePass()));
                          }
                      ),
                    ),
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
