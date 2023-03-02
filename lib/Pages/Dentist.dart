import 'package:flutter/material.dart';

import 'bookingScreen.dart';
import 'myAppointment.dart';

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
      body: 
      
      
      SingleChildScrollView(
        child: Column(
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

        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/tooth.png", height: 220),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 222,
                        height: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "",
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                              "Dentist",
                              style: TextStyle(fontSize: 19, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: <Widget>[
                                // IconTile(
                                //   backColor: Color(0xffFFECDD),
                                //   imgAssetPath: "assets/email.png",
                                // ),
                                // IconTile(
                                //   backColor: Color(0xffFEF2F0),
                                //   imgAssetPath: "assets/call.png",
                                // ),
                                // IconTile(
                                //   backColor: Color(0xffEBECEF),
                                //   imgAssetPath: "assets/video_call.png",

                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Text(
                  "About",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Dr.is a Dentist  in Ghana.",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                           // Image.asset("assets/images/faq.png"),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      color: Colors.black87.withOpacity(0.7),
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width - 268,
                                    child: Text(
                                      "House # 2, Road # 5, ",
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                           // Image.asset("assets/images/faq.png"),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Daily Practice",
                                  style: TextStyle(
                                      color: Colors.black87.withOpacity(0.7),
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width - 268,
                                    child: Text(
                                      '''Monday - Friday
                                      Open till 7 Pm''',
                                      style: TextStyle(color: Colors.grey),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    // Image.asset(
                    //   "assets/images/faq.png",
                    //   width: 180,
                    // )
                  ],
                ),
                Text(
                  "Activity",
                  style: TextStyle(
                      color: Color(0xff242424),
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BookingScreen()));
                              },

                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                          //  child: Image.asset("assets/images/faq.png")
                                    ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                     Text(
                                            "Book a Schedule",
                                            style: TextStyle(color: Colors.white,
                                                fontSize: 15),
                                          ),

                                      ],
                                    ),
                                  ),
                                ),

                            ),
                          ),

                          Container(
                            padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            child: GestureDetector(
                              onTap: (){


                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyAppointments(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [

                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    //  child: Image.asset("assets/images/faq.png")
                                  ),

                                  SizedBox(width: 2),
                                  Container(
                                    // width: MediaQuery.of(context).size.width/2 - 130,
                                    child: Text(
                                      "My Schedules",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),




                  ],
                )

          ),






            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: 130,
            //         height: 40,
            //
            //         decoration: BoxDecoration(
            //             color: Color(0xFFB3CA2E6),
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(70),
            //             )),
            //
            //         // Book appointment.
            //         child: GestureDetector(
            //           onTap: (){
            //             showModalBottomSheet(
            //                 context: context,
            //                 builder: (context) {
            //                   return Column(
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: <Widget>[
            //                       Text("BOOK AN APPOINTMENT",style: TextStyle(fontSize: 10,
            //                           fontWeight: FontWeight.normal,color: Colors.black26),),
            //                       ListTile(
            //                         leading: new Icon(Icons.photo),
            //                         title: new Text('Photo'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                       ListTile(
            //                         leading: new Icon(Icons.music_note),
            //                         title: new Text('Music'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                       ListTile(
            //                         leading: new Icon(Icons.videocam),
            //                         title: new Text('Video'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                       ListTile(
            //                         leading: new Icon(Icons.share),
            //                         title: new Text('Share'),
            //                         onTap: () {
            //                           Navigator.pop(context);
            //                         },
            //                       ),
            //                     ],
            //                   );
            //                 });
            //           },
            //           child: Row(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   children: [
            //                     Text(
            //                       " Book an Appointment ",
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 10,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
        )],
        ),
      ),
    );
  }
}
