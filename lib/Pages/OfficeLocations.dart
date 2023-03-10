import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class officelocation extends StatefulWidget {
  const officelocation({Key? key}) : super(key: key);
  static const String idScreen = "OFFICELOCATION";

  @override
  State<officelocation> createState() => _officelocationState();
}

class _officelocationState extends State<officelocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
          title: Text("Office Locations"),
        ),
        body: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
                padding: const EdgeInsets.all(29.0),
                child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => askaquestion()));
                    },
                    child: FadeInUp(
                      delay: const Duration(milliseconds: 1500),
                      child: Column(
                        children: [
                          Container(
                            // duration: const Duration(milliseconds: 400),
                            // scaleFactor: 1.5,
                            // onPressed: ontap,
                            child: Container(
                              height: 120,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],

                                // image: DecorationImage(
                                //     image: AssetImage(image!), fit: BoxFit.scaleDown, scale: 2)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset("assets/images/hq.png",
                                            height: 100),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, right: 233, left: 2),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.redAccent,
                                              ),
                                              Text(
                                                  "Total House, 43 \n Liberia Road,\n Accra"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            // duration: const Duration(milliseconds: 400),
                            // scaleFactor: 1.5,
                            // onPressed: ontap,
                            child: Container(
                              height: 120,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],

                                // image: DecorationImage(
                                //     image: AssetImage(image!), fit: BoxFit.scaleDown, scale: 2)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Image.asset("assets/images/hq.png",
                                            height: 100),


                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                            "Total House \nClinic \n N Liberia Link,\n Accra, Ghana.")
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            // duration: const Duration(milliseconds: 400),
                            // scaleFactor: 1.5,
                            // onPressed: ontap,
                            child: Container(
                              height: 120,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0,
                                        1.0), // shadow direction: bottom right
                                  )
                                ],

                                // image: DecorationImage(
                                //     image: AssetImage(image!), fit: BoxFit.scaleDown, scale: 2)),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                        Image.asset("assets/images/hq.png",
                                            height: 100),


                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.redAccent,
                                        ),
                                        Text(
                                            "Total House,\n JR3C+GW5, \nLiberation Road, \n Accra")
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))
          ]),
        ));
  }
}
