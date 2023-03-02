import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class officelocation extends StatefulWidget {
  const officelocation({Key? key}) : super(key: key);

  @override
  State<officelocation> createState() => _officelocationState();
}

class _officelocationState extends State<officelocation> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(



      body:    SingleChildScrollView(
        scrollDirection:Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [



            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => askaquestion()));
                },
                child:FadeInUp(
                  delay:const Duration(milliseconds: 1500),
                  child: Column(
                    children: [
                      Container(
                        // duration: const Duration(milliseconds: 400),
                        // scaleFactor: 1.5,
                        // onPressed: ontap,
                        child: Container(
                          height: 120,
                          width: 119,
                          decoration: BoxDecoration(
                              color: Colors. white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(1.0, 1.0), // shadow direction: bottom right
                                )
                              ],


                              //
                              // image: DecorationImage(
                              //     image: AssetImage(image!), fit: BoxFit.scaleDown, scale: 2)),
                          )
                        ),
                      ),
                       SizedBox(
                        height: 10,
                      ),
                      Text(
                        "title"!,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )))])));


  }
}
