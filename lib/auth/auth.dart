class UserModel {
  String? uid;
  String? email;
  String? displayName;
  String? photoURL;
  String? bio;
  String? lastSeen;
  String? role;

  UserModel(
      {this.uid,
      this.email,
      this.displayName,
      this.photoURL,
      this.bio,
      this.lastSeen,
      this.role});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      bio: map['bio'],
      lastSeen: map[DateTime.now()],
      role: map['role'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL':
          'https://www.seekpng.com/png/full/41-410093_circled-user-icon-user-profile-icon-png.png',
      'bio': 'hello there!',
      'lastSeen': DateTime.now(),
      'role': role,
    };
  }
}
