import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase/model/MemoModel.dart';
import 'package:flutter_firebase/firebase/FirebaseOperations.dart';
import 'package:flutter_firebase/utils/Constants.dart';

class FirebaseListing extends StatelessWidget {
  final Color color;

  final String userID;
  FirebaseListing(this.color, this.userID);
  final firebaseoperations = FirebaseOperations();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new StreamBuilder<Event>(
      stream: firebaseoperations.getFirebaseMemoList(),
      builder: (context, event) {
        if (!event.hasData)
          return new Center(
              child: new Text(Constants.loading, textAlign: TextAlign.center));

        Map map = event.data.snapshot.value;
        if (map != null && map.length > 0) {
          return new ListView.builder(
            itemCount: map.length,
            itemBuilder: (BuildContext context, int index) {
              MemoModel user = MemoModel.fromJson(map.values.elementAt(index));
              String key = map.keys.elementAt(index);
              print(key);
              print(map);
              String name = user.title;
              String email = user.notes;

              return new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text("$name"),
                    subtitle: new Text("$email"),
                  ),
                  new Divider(
                    height: 2.0,
                  ),
                ],
              );
            },
          );
        } else {
          return new Center(
              child: new Text(Constants.noDataAvailable,
                  textAlign: TextAlign.center));
        }
      },
    ));
  }
}
