import 'package:flutter/cupertino.dart';

class ChatUsers{
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({@required this.name,@required this.messageText,@required this.imageURL,@required this.time, String secondaryText, String text, String image});
  ChatUsers.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name=map["name"];



  }

  toJson() {
    return {
    name = name,
  };
    }

    ChatUsers copyWith({
  String name

    }) {
      return ChatUsers(
        name: name?? this.name

      );
    }

}

    // phone = dataSnapshot.value["phone"];
    // email = dataSnapshot.value["email"];

    // profilepicture=dataSnapshot.value["profilepicture"];
    // automobile_color = dataSnapshot.value["car_details"]["automobile_color"];
    // automobile_model = dataSnapshot.value["car_details"]["automobile_model"];
    // plate_number = dataSnapshot.value["car_details"]["plate_number"];
