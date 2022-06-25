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
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(

      ),


      body: Container(
        height: 100,
        child: Row(
          children: [
            Text("Dentist Department",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),)

          ],
        ),
      ),
    );
  }
}
