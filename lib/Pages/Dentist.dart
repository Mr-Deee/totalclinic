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
                         image: new AssetImage("assets/images/DENTIST 2.jpg"),
                         fit: BoxFit.fill,
                       )
                   )

               ),
             ),
            
            //061495
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  height: 200,
                  width:200,
                  child: Text(" "),
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/DENTIST.jpg"),
                        fit: BoxFit.fill,
                      )
                  )
              ),
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
                      )
                  )
              ),
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
                      )
                  )
              ),
            )
          ],
        ),
        // Show a dialog

        // dentist department
   
      ],
    ),
 ),


  Padding(
    padding: const EdgeInsets.only(top:10.0,left: 30.0, right: 30.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.blue,

      // Book appointment.
      child: Row(
        children: [
          Row(
            children: [
              Text(
                " Book an Appointment ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
],


      ),
    );
  }
}
