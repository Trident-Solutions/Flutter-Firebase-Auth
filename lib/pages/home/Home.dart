import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/pages/fireabase/FirebaseListing.dart';
import 'package:flutter_firebase/uicontrollers/memodialogcontroller.dart';
import 'package:flutter_firebase/utils/Constants.dart';
import 'package:flutter_firebase/firebase/FirebaseOperations.dart';
import 'package:flutter_firebase/pages/fireabase/FirestoreListing.dart';

class Home extends StatefulWidget {
  Home(this.flag) : super();

  final String title = "Firebase Learning";
  final String flag;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTabIndex = 0;

  FirebaseOperations firebaseOperations = new FirebaseOperations();
  List<User> items;

  List<Widget> _children() => [
        FirebaseListing(Colors.white, widget.flag),
        FireStoreListing(Colors.white, widget.flag, items)
      ];

  onTapped(int index) {
    setState(() {
      print(widget.key);
      currentTabIndex = index;
    });
  }

  TextEditingController _textTitleController = TextEditingController();

  TextEditingController _textMemoController = TextEditingController();

  _displayDialog(BuildContext context, String title) async {
    MemoDialogController.displayDialog(context, title, _textTitleController,
        _textMemoController, currentTabIndex, firebaseOperations);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children();

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.tridentapp),
      ),
      body: children[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(Constants.firebase),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text(Constants.firestore),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentTabIndex == 0) {
            _displayDialog(context, Constants.firebase);
          } else {
            _displayDialog(context, Constants.firestore);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
