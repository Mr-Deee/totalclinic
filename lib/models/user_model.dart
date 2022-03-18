class UserModel {
   String uid;
   String fullName;
   String email;
   String profileImage;
   int dt;

  UserModel({
     this.uid,
     this.fullName,
     this.email,
     this.profileImage,
     this.dt,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['name'],
      email: map['email'],
      profileImage: map['profileImage'],
      dt: map['dt'],
    );
  }
}
