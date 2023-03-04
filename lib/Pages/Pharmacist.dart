import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_sheet_header_title.dart';
import '../widgets/drugstile.dart';

class pharmacy extends StatefulWidget {
  const pharmacy({Key? key}) : super(key: key);

  @override
  State<pharmacy> createState() => _pharmacyState();
}

class _pharmacyState extends State<pharmacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Stack(children: [
              Column(
                children: [
                  SizedBox(
                      height: 191,
                      width: 279,
                      child: Image.asset(
                        "assets/images/back.png",
                      )),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Container(
                        height:MediaQuery.of(context).size.height ,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              blurRadius: 10,
                              //offset: Offset.infinite,
                            ),
                          ],
                          color: Colors.white12,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              23.0,
                            ),
                            topRight: Radius.circular(
                              23.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BottomSheetHeaderTitle(
                                titleText: 'Drugs',
                              ),

                              Column(
                                children: [


                              ],)
                            ],
                          ),
                        ),
                      ),
               ),

                ],
              ),
            ]),
          ),
        ));
  }
}
