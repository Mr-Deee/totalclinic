import 'package:flutter/material.dart';

import '../Pages/chat_page.dart';
import '../models/Doctor.dart';
import '../models/userfeild.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<User> users;
  final List<Doctoruser> doctors;
  const ChatBodyWidget({
    @required this.users,
    @required this.doctors,


    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          //final user = users[index];
          final Doctor= doctors[index];

          return Container(
            height: 75,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatPage(doctor: Doctor),
                ));
              },
              leading: CircleAvatar(
                radius: 25,
                //backgroundImage: NetworkImage(user.urlAvatar),
              ),
              title: Text(Doctor.name),
            ),
          );
        },
        itemCount: doctors.length,

      );
}
