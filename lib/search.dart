import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:totalclinic/DoctorDatabase.dart';
import 'package:totalclinic/widgets.dart';

DocumentSnapshot snapshot;

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  QuerySnapshot searchSnapshot;

  @override
  void initState() {
    getSearch();
  }

  getSearch() async {
    databaseMethods
        .getDoctorBySearch(searchTextEditingController.text.toLowerCase())
        .then((val) {
      print(searchTextEditingController.text.toLowerCase());
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
                //imagePath: searchSnapshot.docs[index]["imagePath"],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Doctor Lookup"),
          // centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [const Color(0xFF6aa6f8), const Color(0xFF1a60be)],
              ),
            ),
          ),
          // title: Text('Title'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 10.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, 0.0),
                  end: Alignment(1.0, 0.0),
                  colors: [
                    const Color(0xFF6aa6f8),
                    const Color(0xFF1a60be)
                  ], // whitish to gray
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 20.0,
                    ),
                    child: TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      controller: searchTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'search...',
                        hintStyle: TextStyle(
                          color: Color(0xFFb1b2c4),
                        ),
                        border: new OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 25.0,
                        ),
                      ),
                      onChanged: (text) {
                        getSearch();
                      },
                    ),
                  ),
                ],
              ),
            ),
            searchList(),
          ],
        )));
  }
}
