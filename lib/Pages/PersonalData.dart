import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class personaldata extends StatefulWidget {
  const personaldata({Key key}) : super(key: key);

  @override
  State<personaldata> createState() => _personaldataState();
}

class _personaldataState extends State<personaldata> {
  String dateofBirth;
  String firstName;
  String lastName;
  int phone;
  String Gender;
  int Age;



  String initValue="Select your Birth Date";
  bool isDateSelected= false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Kindly Add Your Personal Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
    child: SingleChildScrollView(
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

          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
              validator: (val) => val.isEmpty ? 'Enter your Email' : null,
              onChanged: (val) {
                setState(() => lastName = val);
              },
            ),
          ),

          //Dob
          GestureDetector(


              onTap: ()async{
                final datePick= await showDatePicker(
                    context: context,
                    initialDate: new DateTime.now(),
                    firstDate: new DateTime(1900),
                    lastDate: new DateTime(2100)
                );
                if(datePick!=null && datePick!=birthDate){
                  setState(() {
                    birthDate=datePick;
                    isDateSelected=true;
                    birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    new Icon(Icons.calendar_today),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text((isDateSelected ? DateFormat.yMMMd().format(birthDate) : initValue),),
                    )
                  ],
                ),
              ),
          ),
          //
          // Email



          //phone
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Phone',
                  border: OutlineInputBorder()),
              validator: (val) =>
              val.isEmpty ? 'Enter your phone' : null,
              onChanged: (val) {
                setState(() => phone = val as int);
              },
            ),
          ),



      ]
      ),
    )

      ),

    );
  }
}
