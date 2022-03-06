import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalclinic/widgets.dart';

import 'DoctorDatabase.dart';

DocumentSnapshot snapshot;

class CategoryPage extends StatefulWidget {
  final String specialtyName;
  CategoryPage(this.specialtyName);

  @override
  _CategoryPageState createState() => _CategoryPageState(specialtyName);
}

class _CategoryPageState extends State<CategoryPage> {
  String specialtyName;
  String specialtyDescription;
  _CategoryPageState(this.specialtyName);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot specialtyInfoSnapshot;
  QuerySnapshot specialtySnapshot;
  QuerySnapshot searchSnapshot;

  getSpecialtyDoctors(specialtyName) async {
    databaseMethods.getDoctorBySpecialty(specialtyName).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return doctorCard(
                context: context,
                firstName: searchSnapshot.docs[index]["firstName"],
                lastName: searchSnapshot.docs[index]["lastName"],
                prefix: searchSnapshot.docs[index]["prefix"],
                specialty: searchSnapshot.docs[index]["specialty"],
                rank: searchSnapshot.docs[index]["rank"],
                imagePath: searchSnapshot.docs[index]["imagePath"],
              );
            })
        : Container();
  }

  getSpecialtyInfo(specialtyName) async {
    print(specialtyName);
    databaseMethods.getSpecialty(specialtyName).then((val) {
      setState(() {
        specialtySnapshot = val;
      });
    });
  }

  Widget loadSpecialty() {
    return specialtySnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: specialtySnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return specialtyCard(
                    specialtyName:
                        specialtySnapshot.docs[index]["specialtyName"],
                    specialtyDescription: specialtySnapshot.docs[index]
                      ["specialtyDescription"],
                  );
                }),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark,
                ], // whitish to gray
              ),
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
  }

  Widget specialtyCard({
    String specialtyName,
    String specialtyDescription,
  }) {
    return Container(
      child: Text(specialtyDescription ??
          "not found"
              ""),
    );
  }

  @override
  void initState() {
    getSpecialtyInfo(specialtyName);
    getSpecialtyDoctors(specialtyName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              sectionTitle(context, specialtyName.toString()),
              loadSpecialty(),
              searchSnapshot != null
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchSnapshot.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return doctorCard(
                          context: context,
                          firstName:
                              searchSnapshot.docs[index]["firstName"],
                          lastName:
                              searchSnapshot.docs[index]["lastName"],
                          prefix: searchSnapshot.docs[index]["prefix"],
                          specialty:
                              searchSnapshot.docs[index]["specialty"],
                          rank: searchSnapshot.docs[index]["rank"],
                          imagePath:
                              searchSnapshot.docs[index]["imagePath"],
                        );
                      })
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-1.0, 0.0),
                          end: Alignment(1.0, 0.0),
                          colors: [
                            Theme.of(context).primaryColorLight,
                            Theme.of(context).primaryColorDark,
                          ], // whitish to gray
                        ),
                      ),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
