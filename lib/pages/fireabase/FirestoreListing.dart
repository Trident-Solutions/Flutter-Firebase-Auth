import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase/FirebaseOperations.dart';
import 'package:flutter_firebase/model/MemoModel.dart';
import 'package:flutter_firebase/model/User.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/utils/Constants.dart';

class FireStoreListing extends StatelessWidget {
  final Color color;
  final String userID;
  final firebaseoperations = FirebaseOperations();
  final List<User> userList;

  FireStoreListing(this.color, this.userID, this.userList);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new StreamBuilder<QuerySnapshot>(
      stream: firebaseoperations.getFirestoreMemoList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Center(
              child: new Text(Constants.loading, textAlign: TextAlign.center));

        if(snapshot.data.documents.length>0){
        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            MemoModel user = MemoModel.fromJson(document.data);
            String name = user.title;
            String email = user.notes;
            return new ListTile(
              title: new Text('$name'),
              subtitle: new Text('$email'),
            );
          }).toList(),
        );}else{
           return new Center(
              child: new Text(Constants.noDataAvailable,
                  textAlign: TextAlign.center));
        }
      },
    ));
  }
}
