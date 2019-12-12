import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/model/MemoModel.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/utils/Constants.dart';
import 'package:flutter_firebase/uicontrollers/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseOperations {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final FirebaseDatabase fb = FirebaseDatabase.instance;
  final CollectionReference collectionref = null;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> signUp(User user, String password) async {
    FirebaseUser users;

    try {
      users = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      inserUser(user, users.uid);
      return users.uid;
    } catch (error) {
      Alert.showAlert(error.toString());
      return null;
    }
  }

  void inserUser(User user, String userid) {
    try {
      _db
          .collection(Constants.users)
          .document(userid)
          .setData(user.toJson())
          .then((onValue) {
        fb
            .reference()
            .child(Constants.users + '/' + userid)
            .set(user.toJson())
            .then((onValue) {});
      });
    } catch (error) {
      Alert.showAlert(error.toString());
    }
  }

  Stream<QuerySnapshot> getFirestoreMemoList() {
    //  myCollection=_db.collection('Users');
    CollectionReference myCollection = _db.collection(Constants.memo);

    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    return snapshots;
  }

  Stream<Event> getFirebaseMemoList() {
    //  myCollection=_db.collection('Users');
    return FirebaseDatabase.instance.reference().child(Constants.memo).onValue;
  }

  void insertFirebaseMemo(MemoModel memoModel) {
    try {
      fb.reference().child('Memo').push().set(memoModel.toJson());
    } catch (error) {}
  }

  void insertFireStoreMemo(MemoModel memoModel) {
    try {
      _db.collection(Constants.memo).document().setData(memoModel.toJson());
    } catch (error) {
      Alert.showAlert(error.toString());
    }
  }
}
