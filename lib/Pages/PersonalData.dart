import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class personaldata extends StatefulWidget {
  const personaldata({Key key}) : super(key: key);

  @override
  State<personaldata> createState() => _personaldataState();
}

class _personaldataState extends State<personaldata> {
  String dateofBirth;
  String firstName;
  String lastName;
  String Gender;
  int Age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Kindly Add Your Personal Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
    child: Column(
      children:[



        Padding(
          padding:
          const EdgeInsets.only(top: 20.0, left: 30, right: 30),
          child: DropdownButton(
            hint: Gender == null
                ? Text('Gender')
                : Text(
              Gender,
              style: TextStyle(color: Colors.blue),
            ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.blue),
            items: [
              'Male',
              'Female',
              'Rather Not Say'
            ].map(
                  (Genderval) {
                return DropdownMenuItem<String>(
                  value: Genderval,
                  child: Text(Genderval),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                    () {
                  Gender = val.toString();
                },
              );
            },
          ),
        ),

      //FirstName
      SizedBox(height: 20.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'FirstName',
              border: OutlineInputBorder()),
          validator: (val) =>
          val.isEmpty ? 'Enter your FirstName' : null,
          onChanged: (val) {
            setState(() => firstName = val);
          },
        ),
      ),
          //LastName
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'LastName',
                border: OutlineInputBorder()),
            validator: (val) =>
            val.isEmpty ? 'Enter your LastName' : null,
            onChanged: (val) {
              setState(() => lastName = val);
            },
          ),
        ),


        //BMI
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'LastName',
                border: OutlineInputBorder()),
            validator: (val) =>
            val.isEmpty ? 'Enter your LastName' : null,
            onChanged: (val) {
              setState(() => lastName = val);
            },
          ),
        ),

        //Email
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'LastName',
                border: OutlineInputBorder()),
            validator: (val) =>
            val.isEmpty ? 'Enter your LastName' : null,
            onChanged: (val) {
              setState(() => lastName = val);
            },
          ),
        ),



        //phone
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'LastName',
                border: OutlineInputBorder()),
            validator: (val) =>
            val.isEmpty ? 'Enter your LastName' : null,
            onChanged: (val) {
              setState(() => lastName = val);
            },
          ),
        ),



    ]
    )

      ),

    );
  }
}
