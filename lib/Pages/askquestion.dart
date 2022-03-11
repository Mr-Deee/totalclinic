import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:totalclinic/models/userProfile.dart';

import '../progressdialog.dart';
import '../widgets/AdminSelection.dart';

class askaquestion extends StatefulWidget {
  const askaquestion({Key key}) : super(key: key);

  @override
  State<askaquestion> createState() => _askaquestionState();
}


class _askaquestionState extends State<askaquestion> {

  QuerySnapshot userProfileSnapshot;

  // String userFirstName=FirebaseDatabase.instance.
String _categorydropDownValue;
  TextEditingController textarea = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(
        centerTitle: true,
        title: Text("Ask A Doctor"),
        // centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [const Color(0xFFC70F0F), const Color(0xFFEB1515)],
            ),
          ),
        ),
        // title: Text('Title'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: Container(



        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(


    alignment: Alignment.center,
    padding: EdgeInsets.all(20),
    child: Column(
    children: [

      Padding(
        padding:
        const EdgeInsets.only(top: 10.0, left: 30, right: 30),
        child: DropdownButton(
          hint: _categorydropDownValue == null
              ? Text('Choose A Category')
              : Text(
            _categorydropDownValue,
            style: TextStyle(color: Colors.blue),
          ),
          isExpanded: true,
          iconSize: 30.0,
          style: TextStyle(color: Colors.blue),
          items: [
            'General',
            'HIV/AIDS',
            'COVID-19',
          ].map(
                (CategoryVal) {
              return DropdownMenuItem<String>(
                value: CategoryVal,
                child: Text(CategoryVal),
              );
            },
          ).toList(),
          onChanged: (val) {
            setState(
                  () {
                _categorydropDownValue = val.toString();
              },
            );
          },
        ),
      ),


    Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: TextField(
              controller: textarea,
              keyboardType: TextInputType.multiline,
            maxLines:10,
            decoration: InputDecoration(
                border: InputBorder.none,
            hintText: " Enter Your Question?",
            focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(width: 1, color: Colors.white12),
            )
            ),

            ),
            decoration: BoxDecoration(
                color: Colors. white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
            ),
          ),
    ),

      RaisedButton(
          color: Colors.black,
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            AddQuestionstofirestore(context);



            //
            // Future.wait([AddVehiclestofirestore(context),
            //   uploadFile(),]);





          }),
          ]
    )
          ),

        ),
      )
    );
  }

Future<void> AddQuestionstofirestore(BuildContext context) async {

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message: "Adding,Please wait.....",);

      }


  );




  User user = await FirebaseAuth.instance.currentUser;
  if (  _categorydropDownValue != null) {
    await FirebaseFirestore.instance.collection('Questions').doc(_categorydropDownValue ).set({
      'Question Category':_categorydropDownValue,
      'FullName':u["FullName"],
      // 'LastName': UserProfile.userLastName,
      'TextArea': textarea.text.trim(),

      //'ImageList':imageFileList,

    });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return SignInScreen();
    //   }),
    //);

  }

    displayToast("Congratulation, your vehicle has been added", context);
    Navigator.pop(context);


  }
displayToast(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);

}
}



