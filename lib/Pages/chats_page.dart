import 'package:flutter/material.dart';
import 'package:totalclinic/models/Doctor.dart';

import '../api/firebase_api.dart';
import '../widgets/chat_body_widget.dart';
import '../widgets/chat_header_widget.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: StreamBuilder<List<Doctoruser>>(
            stream: FirebaseApi.getDoctors(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return buildText('Something Went Wrong Try later');
                  } else {
                    final doctor = snapshot.data;

                    if (doctor.isEmpty) {
                      return buildText('No Users Found');
                    } else
                      return Column(
                        children: [

                              ChatHeaderWidget(doctors: doctor),
                          ChatBodyWidget(doctors: doctor)
                        ],
                      );
                  }
              }

            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
