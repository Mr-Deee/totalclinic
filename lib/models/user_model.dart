class UserModel {
   String uid;
   String FirstName;
   String LastName;
   String email;
   String profileImage;
   int dob;
   String Gender;

  UserModel({
     this.uid,
     this.FirstName,
    this.LastName,
     this.email,
     this.profileImage,
     this.dob,
    this.Gender,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      FirstName: map['firstName'],
      LastName: map["lastName"],
      Gender: map["Gender"],
      email: map['email'],
      profileImage: map['profileImage'],
      dob: map['d0b'],
    );
  }
   UserModel _userInfo;

   UserModel get userInfo => _userInfo;

   void setUser(UserModel userModel) {
     _userInfo = userModel;

   }
}
