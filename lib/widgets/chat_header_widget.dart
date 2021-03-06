import 'package:flutter/material.dart';

import '../Pages/chat_page.dart';
import '../models/Doctor.dart';
import '../models/userfeild.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<User> users;
  final List<Doctoruser> doctors;
  const ChatHeaderWidget({
    @required this.users,
    Key key, this.doctors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'TotalClinic',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemBuilder: (context, index) {
                  final user = doctors[index];
                  if (index == 0) {
                    return Container(
                      margin: EdgeInsets.only(right: 12),
                      child: CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.search),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: users[index]),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 24,
                          //backgroundImage: NetworkImage(user.urlAvatar),

                        ),
                      ),
                    );

                  }

                },

                itemCount: doctors.length,
              ),

            )

          ],
        ),
      );
}
