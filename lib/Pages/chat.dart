import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chats extends StatelessWidget {
  const chats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, [document] ) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Doctors').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(Colors.black)
              ),
            );
          }else{
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
                itemBuilder: (context,index)=>build(context,snapshot.data.documents[index]),
            );
          //itemCount: snapshot.data.documents.length,);

          }
        },

      )
    );
  }
}
