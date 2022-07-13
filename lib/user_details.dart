class UserDetails {
  String? uid;
  String? email;
  String? displayName;
  String? photoURL;
  String? bio;
  String? lastSeen;

  UserDetails({this.uid, this.email, this.displayName, this.photoURL, this.bio, this.lastSeen});

  // receiving data from server
  factory UserDetails.fromMap(map) {
    return UserDetails(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      bio: map['bio'],
      lastSeen: map[DateTime.now()],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'bio': 'hello there!',
      'lastSeen' : DateTime.now()
    };
  }
}