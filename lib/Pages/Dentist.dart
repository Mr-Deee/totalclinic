import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dentist extends StatefulWidget {
  static const String idScreen = "Cardiology";

  // const cardiologypage({Key key}) : super(key: key);

  @override
  State<Dentist> createState() => _DentistpageState();
}

class _DentistpageState extends State<Dentist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dentists"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Text(""),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image:
                                new AssetImage("assets/images/DENTIST 2.jpg"),
                            fit: BoxFit.fill,
                          ))),
                    ),

                    //061495
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Text(" "),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image: new AssetImage("assets/images/DENTIST.jpg"),
                            fit: BoxFit.fill,
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Text(" images "),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image: new AssetImage("assets/images/DENTIST3.jpg"),
                            fit: BoxFit.fill,
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          height: 200,
                          width: 200,
                          child: Text(" Images "),
                          decoration: new BoxDecoration(
                              image: new DecorationImage(
                            image: new AssetImage("assets/images/DENTIST3.jpg"),
                            fit: BoxFit.fill,
                          ))),
                    )
                  ],
                ),
                // Show a dialog

                // dentist department
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 130,
                  height: 40,

                  decoration: BoxDecoration(
                      color: Color(0xFFB3CA2E6),
                      borderRadius: BorderRadius.all(
                        Radius.circular(70),
                      )),

                  // Book appointment.
                  child: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("BOOK AN APPOINTMENT",style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal,color: Colors.black26),),
                                ListTile(
                                  leading: new Icon(Icons.photo),
                                  title: new Text('Photo'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.music_note),
                                  title: new Text('Music'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.videocam),
                                  title: new Text('Video'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Icons.share),
                                  title: new Text('Share'),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                " Book an Appointment ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
