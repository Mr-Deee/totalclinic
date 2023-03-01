import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bookingScreen.dart';
import 'myAppointment.dart';

class Gynecology extends StatefulWidget {
  const Gynecology({Key? key}) : super(key: key);

  @override
  State<Gynecology> createState() => _GynecologyState();
}

class _GynecologyState extends State<Gynecology> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Gynecologist"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
                            Image.asset("assets/images/gynelog.png",
                                height: 220),
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
                                    "gynecology",
                                    style: TextStyle(
                                        fontSize: 19, color: Colors.grey),
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
                        "Dr.is a Gynecologist  in Ghana.his medical degree from Duke University School of Medicine and has been in practice for more than 20 years. ",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                            color:
                                                Colors.black87.withOpacity(0.7),
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              268,
                                          child: Text(
                                            "House # 2, Road #",
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Daily Practice",
                                        style: TextStyle(
                                            color:
                                                Colors.black87.withOpacity(0.7),
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              268,
                                          child: Text(
                                            '''Monday - Friday
Open till 7 Pm''',
                                            style:
                                                TextStyle(color: Colors.grey),
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
                        height: 1,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => BookingScreen()));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 23, horizontal: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          //  child: Image.asset("assets/images/faq.png")
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Book a Schedule",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 23, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: GestureDetector(
                                onTap: () {
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
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      //  child: Image.asset("assets/images/faq.png")
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(

                                      child: Text(
                                        "My Schedules",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
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
                  )),

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
            )
          ],
        ),
      ),
    );
  }
}
